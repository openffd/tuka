# frozen_string_literal: true

module Tuka
  module Bash
    using CoreExtensions

    BASH_PROFILE_PATH = '~/.bash_profile'
    BASHRC_PATH       = '~/.bashrc'
    TUKARC_PATH       = '~/.tukarc'

    SOURCE_BASH_PROFILE_CMD = "source #{BASH_PROFILE_PATH}".yellow

    LOAD_TUKARC_CMD       = "[ -r #{TUKARC_PATH} ] && . #{TUKARC_PATH}"
    LOAD_TUKARC_CMD_REGEX = %r{\n\[ -r ~/.tukarc \] && . ~/.tukarc\n}.freeze

    ENV_BITBUCKET_USERNAME = ENV['BITBUCKET_USERNAME']
    ENV_BITBUCKET_PASSWORD = ENV['BITBUCKET_PASSWORD']

    def bashrc
      File.open(File.expand_path(BASHRC_PATH))
    rescue StandardError
      nil
    end

    class BashProfileMissingError < StandardError
      def initialize(msg = 'Unable to detect a bash_profile in the home directory.')
        super(msg)
      end
    end

    class BashProfileTukarcNotSourcedError < StandardError
      def initialize(msg = 'The bash')
        super(msg)
      end
    end

    def bash_profile
      File.open(File.expand_path(BASH_PROFILE_PATH))
    rescue StandardError
      nil
    end

    def bash_profile_setup?
      raise BashProfileMissingError if bash_profile.nil?
      raise BashProfileTukarcNotSourcedError unless bash_profile.read =~ LOAD_TUKARC_CMD_REGEX

      true
    end

    def create_bash_profile
      touch(filename: File.expand_path(BASH_PROFILE_PATH), content: LOAD_TUKARC_CMD)
    end

    def add_line_sourcing_tukarc_to_bash_profile
      append_to_file(File.expand_path(BASH_PROFILE_PATH), string: "\n#{LOAD_TUKARC_CMD}")
    end

    def bash_relogin
      system 'exec', 'bash', '-l'
    end
  end
end
