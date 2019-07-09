# frozen_string_literal: true

module System
  refine Kernel do
    def rm(path)
      system 'rm', path
    end

    def rm_rf(path)
      system 'rm', '-rf', path
    end
  end

  module Xcodeproj
    refine Kernel do
      def xcproj_show
        system 'xcodeproj', 'show'
      end
    end
  end
end
