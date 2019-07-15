# frozen_string_literal: true

require 'json'
require 'ostruct'
require 'forwardable'

module Tuka
  class Tukafile
    extend Forwardable
    using CoreExtensions
    using CoreExtensions::ObjcFilenameString

    def_delegators :@struct, :library, :project_info, :server

    attr_reader :path

    BASENAME = 'Tukafile'
    USER_AGENT_RANGE = (1..9).freeze
    DAYS_RANGE = (14..84).freeze # 2 weeks to 3 months range
    PROTOCOLS = %i[http https].freeze
    HEADERS_COUNT_RANGE = (0..6).freeze
    SWIFT_VERSIONS = %w[4.1 4.2 5.0].freeze
    private_constant :USER_AGENT_RANGE, :PROTOCOLS, :HEADERS_COUNT_RANGE, :SWIFT_VERSIONS

    SERVER_URL_TYPES = { Base64: 'base64', IPv4: 'ipv4', URL: 'url' }.freeze
    SERVER_URL_TYPES.values.each do |type|
      String.define_method("#{type}?") do
        eql? type
      end
    end

    def initialize(path)
      @path = path
      begin
        @struct = JSON.parse(IO.read(@path), object_class: OpenStruct)
      rescue JSON::ParserError => _
        raise StandardError, 'Downloaded Tukafile has content with invalid format'
      end
    end

    def error
      messages = Messages::TukafileErrors.constants(false).sort.map(&Messages::TukafileErrors.method(:const_get))
      private_methods.grep(/valid_*/).sort.each_with_index { |m, i| return messages[i] unless send(m) }

      nil
    end

    def valid?
      error.nil?
    end

    def dump
      File.open(@path, 'w') { |file| file.puts JSON.pretty_generate(JSON.parse(@struct.as_hash.to_json)) }
    end

    def get_server_url_cipher(bundle_id)
      seed = (project_info.bundle_id || bundle_id).sum
      decoded_server_url.rot_cipher(seed)
    end

    def decoded_server_url
      return Base64.decode64(server.url) if server.url_type.base64?

      server.url
    end

    private

    def valid_library?
      require 'digest/sha1'
      string = library.name + library.url
      Digest::SHA1.hexdigest(string) == library.digest
    end

    def valid_server_protocol?
      return true if server.protocol.nil?

      PROTOCOLS.include? server.protocol.to_sym
    end

    def valid_server_url_type?
      SERVER_URL_TYPES.value? server.url_type
    end

    def valid_server_url?
      case server.url_type
      when SERVER_URL_TYPES[:Base64]
        server.url.valid_base64?
      when SERVER_URL_TYPES[:IPv4]
        server.url.valid_ipv4?
      when SERVER_URL_TYPES[:URL]
        server.url.valid_url?
      end
    end

    def valid_server_url_path?
      return false if server.url_path.nil?

      server.url_path =~ /\A[a-zA-Z0-9]+\z/
    end

    def valid_server_user_agent?
      USER_AGENT_RANGE.cover? server.user_agent.to_i
    end

    def valid_server_inactive_days?
      days = server.inactive_days.to_i || DAYS_RANGE.begin
      DAYS_RANGE.cover? days
    end

    def valid_project_info_xcodeproj?
      return false if project_info.xcodeproj.nil?

      File.exist? project_info.xcodeproj
    end

    def valid_project_info_type?
      Project::TYPES.value? project_info.type
    end

    def valid_project_info_bundle_id?
      return true if project_info.bundle_id.nil?

      project_info.bundle_id =~ /^(com|ios)\.[A-Za-z0-9]+\.[A-Za-z0-9]+$/
    end

    def valid_project_info_receptor_name?
      receptor_name = project_info.receptor_name
      return true if receptor_name.nil?

      receptor_name.valid_objc_filename?
    end

    def valid_project_info_headers?
      return true if project_info.headers.nil?

      HEADERS_COUNT_RANGE.cover? project_info.headers
    end

    def valid_project_info_prefix?
      prefix = project_info.prefix
      return false if prefix.nil?

      prefix == prefix[/[a-zA-Z]+/]
    end

    def valid_project_info_swift_version?
      return true if project_info.swift_version.nil?

      SWIFT_VERSIONS.include? project_info.swift_version.to_s
    end
  end
end
