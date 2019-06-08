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
          puts
          puts 'The required credentials are already set. Setup is unnecessary. Exiting...'
          exit
        end
      rescue StandardError
        Whirly.configure spinner: 'vertical_bars', position: 'below', color: false
        Whirly.start do
          Whirly.status = 'Initializing Credentials Setup for Tuka...'.magenta
          sleep 1.5
        end
        puts
      end

      def check_bash_profile
        puts
        puts '[✓] Checked ~/.bash_profile configuration => OK' if bash_profile_setup?
      rescue BashProfileTukarcNotSourcedError
        puts '[✓] Detected ~/.bash_profile exists, added lines for sourcing ~/.tukarc'
        add_line_sourcing_tukarc_to_bash_profile
      rescue BashProfileMissingError
        puts '[✓] Created ~/.bash_profile'
        create_bash_profile
      end

      def create_tukarc
        puts
        tukarc_setup?
      rescue TukarcMissingError
        rescue_tukarc_missing
        prompt_bash_relogin
      rescue TukarcIncompleteVarsError
        rescue_tukarc_incomplete_vars
        prompt_bash_relogin
      rescue TukarcNotLoadedError
        rescue_tukarc_not_loaded
        prompt_bash_relogin
      end

      def display_command_completion
        puts
        puts 'End'
      end

      private

      def rescue_tukarc_missing
        require 'tuka/templates/tukarc/tukarc_generator'

        puts '[✓] Created ~/.tukarc'
        TukarcGenerator.new.generate
        open_file(File.expand_path(TUKARC_PATH))
      end

      def rescue_tukarc_not_loaded
        puts '[✗] The required environment vars are not sourced yet!'
        puts
        puts 'Check if the values in ~/.tukarc are correct.'
        prompt_open_tukarc
      end

      def rescue_tukarc_incomplete_vars
        puts '[✗] Some required environment vars are not set.'
        puts
        puts 'Check if the values in ~/.tukarc are correct.'
        prompt_open_tukarc
      end

      def prompt_open_tukarc
        puts
        ask '[ Press ENTER to open ~/.tukarc ]'.yellow
        clear_prev_line
        puts 'Opening ~/.tukarc...'
        sleep 0.5
        open_file(File.expand_path(TUKARC_PATH))
        puts
        puts 'Set the required environment variables in the ~/.tukarc file. Save and close.'
      end

      def prompt_bash_relogin
        puts
        ask '[ Press ENTER to load ~/.tukarc environment vars ]'.yellow
        clear_prev_line
        puts 'Loading ~/.tukarc environment vars...'
        sleep 0.5
        bash_relogin
      end
    end
  end
end
