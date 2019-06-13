# frozen_string_literal: true

module Tuka
  module Credentials
    module Bitbucket
      USERNAME = ENV['BITBUCKET_USERNAME'].to_s
      PASSWORD = ENV['BITBUCKET_PASSWORD'].to_s
    end

    module NextCloud
      USERNAME = ENV['NEXTCLOUD_USERNAME'].to_s
      PASSWORD = ENV['NEXTCLOUD_PASSWORD'].to_s
    end

    class NilError < StandardError
      def initialize(msg = 'One or more required credentials are not set.')
        super(msg)
      end
    end

    class InvalidError < StandardError
      def initialize(msg = 'One or more required credentials is invalid.')
        super(msg)
      end
    end

    def check_bitbucket_credentials
      raise StandardError, NilError.new if Bitbucket::USERNAME.empty? || Bitbucket::PASSWORD.empty?
      raise StandardError, InvalidError.new if Bitbucket::USERNAME.strip.empty? || Bitbucket::PASSWORD.strip.empty?
    end

    def check_nextcloud_credentials
      raise StandardError, NilError.new if NextCloud::USERNAME.empty? || NextCloud::PASSWORD.empty?
      raise StandardError, InvalidError.new if NextCloud::USERNAME.strip.empty? || NextCloud::PASSWORD.strip.empty?
    end
  end
end
