# frozen_string_literal: true

module Tuka
  module Bash
    BASH_PROFILE_PATH = '~/.bash_profile'
    BASHRC_PATH       = '~/.bashrc'
    TUKARC_PATH       = '~/.tukarc'

    LOAD_TUKARC_CMD       = "[ -r #{TUKARC_PATH} ] && . #{TUKARC_PATH}"
    LOAD_TUKARC_CMD_REGEX = %r{/\n\[ -r ~\/.tukarc \] && . ~\/.tukarc\n/}.freeze

    ENV_BITBUCKET_USERNAME = ENV['BITBUCKET_USERNAME']
    ENV_BITBUCKET_PASSWORD = ENV['BITBUCKET_PASSWORD']

    def bash_profile
      File.open(File.expand_path(BASH_PROFILE_PATH))
    rescue StandardError
      nil
    end

    def bash_profile_setup?
      return false if bash_profile.nil?

      bash_profile.read =~ LOAD_TUKARC_CMD_REGEX
    end

    def source_bash_profile
      system '.', BASH_PROFILE_PATH
    end

    def bashrc
      File.open(File.expand_path(BASHRC_PATH))
    rescue StandardError
      nil
    end

    def tukarc
      File.open(File.expand_path(TUKARC_PATH))
    rescue StandardError
      nil
    end

    class TukarcMissingError < StandardError
      def initialize(msg = 'Unable to locate a `.tukarc` file in the home directory.')
        super
      end
    end

    class TukarcNotLoadedError < StandardError
      def initialize(msg = 'The `.tukarc` file in the home directory is not sourced.')
        super
      end
    end

    class TukarcIncompleteVarsError < StandardError
      def initialize(msg = '')
        super
      end
    end

    def tukarc_setup?
      raise TukarcMissingError if tukarc.nil?
      raise TukarcNotLoadedError if ENV_BITBUCKET_USERNAME.nil? && ENV_BITBUCKET_PASSWORD.nil
      raise TukarcIncompleteVarsError if ENV_BITBUCKET_USERNAME.to_s.strip.empty?
      raise TukarcIncompleteVarsError if ENV_BITBUCKET_PASSWORD.to_s.strip.empty?

      true
    end
  end
end
