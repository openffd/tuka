# frozen_string_literal: true

module Tuka
  module Commands
    class Install < Command
      using System::Xcode
      using System::Xcodeproj

      CMDS = [ProjectStatus, GenerateLibrary, GeneratePodfile, GenerateReceptor].freeze
      private_constant :CMDS

      def check_tukafile_existence
        raise StandardError, "Missing Tukafile, generate one by running 'tuka #{Init::USAGE}'" if tukafile.nil?
      end

      def check_tukafile_validity
        raise StandardError, tukafile.error unless tukafile.valid?
      end

      def kill_xcode_pre_installation
        puts
        puts 'Making sure Xcode is closed pre-installation...'
        kill_xcode
        sleep 1
      end

      def install
        CMDS.each do |klass|
          cmd = klass.new
          cmd.options = { quiet: true, yes: true }
          cmd.invoke_all
        end
      end

      def reopen_xcode_post_installation
        open_file(xcworkspace)
      end

      def display_command_completion
        puts
        puts 'End'
      end
    end
  end
end
