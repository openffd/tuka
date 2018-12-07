# frozen_string_literal: true

require 'json'
require 'ostruct'
require 'forwardable'

module Tuka
  class Tukafile
    extend Forwardable
    using CoreExtensions

    def_delegators :@struct, :library, :project_info, :server

    attr_reader :path

    def self.basename
      'Tukafile'
    end

    def self.server_url_types
      { Base64: 'base64', IPv4: 'ipv4', URL: 'url' }
    end

    def initialize(path)
      @path = path
      @struct = JSON.parse(IO.read(@path), object_class: OpenStruct)
    end

    def error
      return "#{Tukafile.basename} `library' is invalid."                     unless valid_library?
      return "#{Tukafile.basename} `server.url_type' is invalid."             unless valid_server_url_type?
      return "#{Tukafile.basename} `server.url' is invalid."                  unless valid_server_url?
      return "#{Tukafile.basename} `server.user_agent' is invalid."           if server.user_agent.nil?
      return "#{Tukafile.basename} `project_info.xcodeproj' is invalid."      unless valid_project_info_xcodeproj?
      return "#{Tukafile.basename} `project_info.type' is invalid."           unless valid_project_info_type?
      return "#{Tukafile.basename} `project_info.bundle_id' is invalid."      unless valid_project_info_bundle_id?
      return "#{Tukafile.basename} `project_info.receptor_name' is invalid."  unless valid_project_info_receptor_name?
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
      return Base64.decode64(server.url) if server.url_type == Tukafile.server_url_types[:Base64]

      server.url
    end

    private

    def valid_library?
      require 'digest/sha1'
      string = library.name + library.url
      Digest::SHA1.hexdigest(string) == library.digest
    end

    def valid_server_url_type?
      Tukafile.server_url_types.value? server.url_type
    end

    def valid_server_url?
      case server.url_type
      when Tukafile.server_url_types[:Base64]
        server.url.base64?
      when Tukafile.server_url_types[:IPv4]
        server.url.ipv4?
      when Tukafile.server_url_types[:URL]
        server.url.url?
      end
    end

    def valid_project_info_xcodeproj?
      return false if project_info.xcodeproj.nil?

      File.exist? project_info.xcodeproj
    end

    def valid_project_info_type?
      Project.types.value? project_info.type
    end

    def valid_project_info_bundle_id?
      return true if project_info.bundle_id.nil?

      project_info.bundle_id =~ /(com|ios)\.[A-Za-z0-9]+\.[A-Za-z0-9]+/
    end

    def valid_project_info_receptor_name?
      receptor_name = project_info.receptor_name
      return true if receptor_name.nil?

      return false if receptor_name.empty?

      receptor_name.scan(/(\W|\d)/).empty?
    end
  end
end
