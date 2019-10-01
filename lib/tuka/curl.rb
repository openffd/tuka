# frozen_string_literal: true

module Curl
  class Easy
    attr_accessor :should_show_msg
  end

  def self.basic_curl
    curl = Curl::Easy.new
    curl.connect_timeout = 4
    curl.timeout = 4
    curl.should_show_msg = false
    curl.on_complete  { |easy| puts '[✓] Curl completed with status: ' + easy.status.yellow if easy.should_show_msg }
    curl.on_success   { |easy| puts '[✓] Curl was successful' if easy.should_show_msg }
    curl.on_failure   { |easy, code| puts 'Curl Error: ' + code if easy.should_show_msg }
    curl
  end

  module Shortcuts
    Response = OpenStruct
    Response.class_eval do
      def successful?
        code.to_s =~ /20+/
      end
    end

    def perform_curl(url:)
      curl = Curl.basic_curl.dup
      curl.url = url.to_s
      curl.perform
      Response.new(code: curl.response_code.to_s, body: curl.body_str.to_s)
    end

    def perform_authenticated_curl(url:, username:, password:)
      curl = Curl.basic_curl.dup
      curl.url = url.to_s
      curl.http_auth_types = :basic
      curl.username = username.to_s
      curl.password = password.to_s
      curl.perform
      Response.new(code: curl.response_code.to_s, body: curl.body_str.to_s)
    end
  end
end
