# frozen_string_literal: true

module Curl
  def self.basic_curl
    curl = Curl::Easy.new
    curl.on_complete  { |_| puts 'Complete' }
    curl.on_success   { |_| puts 'Success' }
    curl.on_failure   { |_, code| puts 'Curl Error: ' + code }
    curl
  end

  module Shortcuts
    def curl(url)
      curl = Curl.basic_curl
      curl.url = url
      curl.perform
    end

    def curl_with_auth(url)
      curl = Curl.basic_curl
      curl.url              = url
      curl.http_auth_types  = :basic
      curl.username         = 'username'
      curl.password         = 'password123!'
      curl.perform
    end
  end
end
