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

    class BashProfileMissingError < StandardError
    end

    class BashProfileTukarcNotSourcedError < StandardError
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

    def source_bash_profile
      system '.', BASH_PROFILE_PATH
    end

    def bashrc
      File.open(File.expand_path(BASHRC_PATH))
    rescue StandardError
      nil
    end
  end
end
