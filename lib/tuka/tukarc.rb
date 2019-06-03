# frozen_string_literal: true

module Tuka
  module Bash
    class TukarcMissingError < StandardError
      def initialize(msg = 'Unable to locate a `.tukarc` file in the home directory.')
        super(msg)
      end
    end

    class TukarcNotLoadedError < StandardError
      def initialize(msg = 'The `.tukarc` file in the home directory is not sourced.')
        super(msg)
      end
    end

    class TukarcIncompleteVarsError < StandardError
      def initialize(msg = 'One or more `.tukarc` environment vars were not set correctly.')
        super(msg)
      end
    end

    def tukarc
      File.open(File.expand_path(TUKARC_PATH))
    rescue StandardError
      nil
    end

    def tukarc_setup?
      raise TukarcMissingError if tukarc.nil?
      raise TukarcNotLoadedError if ENV_BITBUCKET_USERNAME.nil? && ENV_BITBUCKET_PASSWORD.nil?
      raise TukarcIncompleteVarsError if ENV_BITBUCKET_USERNAME.to_s.strip.empty?
      raise TukarcIncompleteVarsError if ENV_BITBUCKET_PASSWORD.to_s.strip.empty?

      true
    end
  end
end
