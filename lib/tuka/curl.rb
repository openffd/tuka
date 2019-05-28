# frozen_string_literal: true

module Curl
  class Easy
    attr_accessor :should_display_msg
  end

  def self.basic_curl
    curl = Curl::Easy.new
    curl.connect_timeout = 4
    curl.timeout = 4
    curl.should_display_msg = false
    curl.on_complete  {|curl| puts '[✓] Curl completed with status: ' + curl.status.yellow if should_display_msg }
    curl.on_success   {|curl| puts '[✓] Curl was successful' if should_display_msg }
    curl.on_failure   {|_, code| puts 'Curl Error: ' + code if should_display_msg }
    curl
  end

  module Shortcuts
    require 'ostruct'

    def perform_curl(url:)
      curl = Curl.basic_curl.dup
      curl.url = url
      curl.perform

      response = OpenStruct.new
      response.code = curl.response_code
      response.body = curl.body_str
      response
    end

    def perform_curl_with_auth(url:)
      curl = Curl.basic_curl.dup
      curl.url              = url
      curl.http_auth_types  = :basic
      curl.username         = 'username'
      curl.password         = 'password123!'
      curl.perform

      response = OpenStruct.new
      response.code = curl.response_code
      response.body = curl.body_str
      response
    end
  end
end
