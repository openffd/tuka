# frozen_string_literal: true

module Tuka
  module Xcodebuild
    COMMAND = 'xcodebuild'

    def get_xcversion
      system COMMAND, '-version', '2>', 'dev/null'
    end
  end
end
