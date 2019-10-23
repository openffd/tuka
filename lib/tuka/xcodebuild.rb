# frozen_string_literal: true

module Tuka
  module Xcodebuild
    using CoreExtensions::SubCommand

    CMD = 'xcodebuild'
    LS_SUBCMD = %w[list exec].as_same_keyval_hash

    class Command

    end

    COMMAND = 'xcodebuild'

    def xcode_info
      @xcode_info ||= `#{COMMAND} -version 2> /dev/null`.chomp.sub(/\n/, ', ')
    end

    def get_project_build_setting(key)
      res = `#{COMMAND} -project "#{@xcodeproj}" -showBuildSettings 2> /dev/null | grep -E "\s+#{key}"`
      return nil if res.empty?

      res.partition("\n").first.partition('= ').last
    end
  end
end
