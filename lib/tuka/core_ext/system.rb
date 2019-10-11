# frozen_string_literal: true

module System
  NULL_DEVICE = '/dev/null'

  refine Kernel do
    def rm(path)
      system 'rm', path
    end

    def rm_rf(path)
      system 'rm', '-rf', path
    end

    def cmd_not_found?(cmd)
      ! system 'which', cmd, '>', NULL_DEVICE
    end
  end

  module Xcode
    APP_NAME = 'Xcode'

    refine Kernel do
      def kill_xcode
        system 'pkill', APP_NAME
      end
    end
  end

  module Xcodeproj
    COMMAND = 'xcodeproj'

    refine Kernel do
      def xcproj_show
        `#{COMMAND} show`
      end
    end
  end
end
