# frozen_string_literal: true

module Tuka
  module Commands
    class Uninstall < Command
      using CoreExtensions

      USAGE = 'uninstall'

      namespace :uninstall
      desc 'Removes Tuka related files and settings from an iOS project'

      def display
        print_newline
        puts 'To be implemented soon.'
      end
    end
  end
end
