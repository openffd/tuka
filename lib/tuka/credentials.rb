# frozen_string_literal: true

module Tuka
  module Credentials
    BITBUCKET_USERNAME = ENV['BITBUCKET_USERNAME'].to_s
    BITBUCKET_PASSWORD = ENV['BITBUCKET_PASSWORD'].to_s

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

    def check_credentials
      raise StandardError, NilError.new if BITBUCKET_USERNAME.empty? || BITBUCKET_PASSWORD.empty?
      raise StandardError, InvalidError.new if BITBUCKET_USERNAME.strip.empty? || BITBUCKET_PASSWORD.strip.empty?
    end
  end
end
