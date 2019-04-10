# frozen_string_literal: true

module Tuka
  module Commands
    class Uninstall < Command
      def self.usage
        'uninstall'
      end

      namespace :uninstall
      desc 'Removes Tuka related files and settings from an iOS project'

      def display
        puts "\nTo be implemented soon."
      end
    end
  end
end
