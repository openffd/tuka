# frozen_string_literal: true

module Tuka
  module Commands
    class SetCredentials < Thor::Group
      include Bash
      include Thor::Actions

      using CoreExtensions

      def clear_terminal
        clear
      end

      def check_prior_setup
        if tukarc_setup?
          print_newline
          puts 'The required credentials are already set. Setup is unnecessary. Exiting...'
          exit
        end
      rescue StandardError
        print_newline
        puts 'Initializing Credentials Setup for Tuka...'.magenta
        sleep 1
      end

      def check_bash_profile
        print_newline
        puts '[✓] Checked ~/.bash_profile configuration => OK' if bash_profile_setup?
      rescue BashProfileTukarcNotSourcedError
        puts '[✓] Detected ~/.bash_profile exists, added lines for sourcing ~/.tukarc'
        add_line_sourcing_tukarc_to_bash_profile
      rescue BashProfileMissingError
        puts '[✓] Created ~/.bash_profile'
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
      ensure
        # TODO: bash_relogin
      end

      def display_command_completion
        print_newline
        puts 'End'
      end

      private

      def rescue_tukarc_missing
        puts '[✓] Created ~/.tukarc'
        TukarcGenerator.new.generate
        open_file(File.expand_path(TUKARC_PATH))
      end

      def rescue_tukarc_not_loaded
        puts 'The required environment vars are not sourced yet!'
        puts 'Check if the values in ~/.tukarc are correct...'
        prompt_open_tukarc
      end

      def rescue_tukarc_incomplete_vars
        puts 'Some required environment vars are not set yet.'
        puts 'Check if the values in ~/.tukarc are correct...'
        prompt_open_tukarc
      end

      def prompt_open_tukarc
        print_newline
        ask '  [ Press Return(⏎ ) key to open ~/.tukarc ]'.yellow
        clear_prev_line
        print 'Opening ~/.tukarc...'
        sleep 0.5
        open_file(File.expand_path(TUKARC_PATH))
      end
    end
  end
end
