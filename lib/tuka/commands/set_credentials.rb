# frozen_string_literal: true

module Tuka
  module Commands
    class SetCredentials < Thor::Group
      include Bash

      using CoreExtensions

      def check_prior_setup
        if tukarc_setup?
          print_newline
          puts 'The required credentials are already set. Setup is unnecessary. Exiting...'
          exit
        end
      rescue StandardError
        print_newline
        puts 'Initializing Credentials Setup for Tuka...'.magenta
      end

      def check_bash_profile
        print_newline
        puts '[✓] Checked ~/.bash_profile configuration => OK' if bash_profile_setup?
      rescue BashProfileTukarcNotSourcedError
        puts '[✓] Detected ~/.bash_profile exists, added lines to source ~/.tukarc'
        add_line_sourcing_tukarc_to_bash_profile
      rescue BashProfileMissingError
        puts '[✓] Created `~/.bash_profile`'
        create_bash_profile
      end

      def create_tukarc
        print_newline
        tukarc_setup?
      rescue TukarcMissingError
        rescue_tukarc_missing
      rescue TukarcIncompleteVarsError
        rescue_tukarc_incomplete_vars
      rescue TukarcNotLoadedError
        rescue_tukarc_not_loaded
      end

      private

      def rescue_tukarc_missing
        puts '[✓] Created ~/.tukarc'
        TukarcGenerator.new.generate
        open_file(File.expand_path(TUKARC_PATH))
      end

      def rescue_tukarc_not_loaded
        puts 'The environment vars are not sourced yet.'
        puts 'Check if the values in `~/.tukarc` are correct, then run `source ~/.bash_profile`.'
        open_file(File.expand_path(TUKARC_PATH))
      end

      def rescue_tukarc_incomplete_vars
        puts 'Some environment vars are not set yet.'
        puts 'Modify ~/.tukarc, save, then run `source ~/.bash_profile`.'
        open_file(File.expand_path(TUKARC_PATH))
      end
    end
  end
end
