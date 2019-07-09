# frozen_string_literal: true

module Tuka
  module Commands
    class Install < Command
      using System::Xcodeproj

      def install
        xcproj_show

        [GenerateLibrary, GeneratePodfile, GenerateReceptor].each do |klass|
          cmd = klass.new
          cmd.options = { quiet: true, yes: true }
          cmd.invoke_all
        end
      end

      def display_command_completion
        puts
        puts 'End'
      end
    end
  end
end
