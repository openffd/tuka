# frozen_string_literal: true

module Tuka
  module Commands
    class Uninstall < Command
      def self.usage
        'uninstall'
      end

      namespace :uninstall
      desc 'Removes or reverts any iOS project files or settings related to Tuka'

      def display
        puts "\nTBI SOON!"
      end
    end
  end
end
