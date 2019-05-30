# frozen_string_literal: true

module Tuka
  module Commands
    class Automatic < Command
      using CoreExtensions

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
        cmd = GenerateReceptor.new
        cmd.options = { quiet: true }
        cmd.invoke_all
      end

      def display_command_completion
        print_newline
        puts 'End'
      end
    end
  end
end
