# frozen_string_literal: true

module Tuka
  module Bash
    BASH_PROFILE_PATH = '~/.bash_profile'
    BASHRC_PATH       = '~/.bashrc'
    TUKARC_PATH       = '~/.tukarc'

    def bash_profile
      begin File.open(File.expand_path(BASH_PROFILE_PATH)) rescue nil end
    end

    def bashrc
      begin File.open(File.expand_path(BASHRC_PATH)) rescue nil end
    end

    def tukarc
      begin File.open(File.expand_path(TUKARC_PATH)) rescue nil end
    end
  end
end
