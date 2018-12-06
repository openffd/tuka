# frozen_string_literal: true

module Tuka
  module Commands
    class Automatic < Command
      def self.usage
        'automatic'
      end

      namespace :automatic
      desc 'Auto-completes the Tuka installation if a Tukafile was previously initialized for the iOS project'

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
