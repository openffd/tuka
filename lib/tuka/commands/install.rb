# frozen_string_literal: true

module Tuka
  module Commands
    class Install < Command
      using System::Xcodeproj

      def check_tukafile_existence
        raise StandardError, "Missing Tukafile, generate one by running 'tuka #{Init::USAGE}'" if tukafile.nil?
      end

      def check_tukafile_validity
        raise StandardError, tukafile.error unless tukafile.valid?
      end

      def install
        [ProjectStatus, GenerateLibrary, GeneratePodfile, GenerateReceptor].each do |klass|
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
