# frozen_string_literal: true

module Tuka
  module Commands
    class Automatic < Command
      def self.usage
        'automatic'
      end

      namespace :automatic
      desc 'Automagically completes installation to an iOS project'

      def generate_library
        cmd = GenerateLibrary.new
        cmd.options = { quiet: true }
        cmd.invoke_all
      end

      def generate_podfile
        cmd = GeneratePodfile.new
        cmd.options = { quiet: true, yes: true }
        cmd.invoke_all
      end

      def add_receptor
        cmd = AddReceptor.new
        cmd.options = { quiet: true }
        cmd.invoke_all
      end

      def display_command_completion
        puts "\nEnd"
      end
    end
  end
end
