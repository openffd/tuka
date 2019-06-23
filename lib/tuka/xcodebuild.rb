# frozen_string_literal: true

module Tuka
  module Xcodebuild
    COMMAND = 'xcodebuild'

    def xcode_info
      @xcode_info ||= `#{COMMAND} -version 2> /dev/null`.chomp.sub(/\n/, ', ')
    end
  end
end
