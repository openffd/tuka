# frozen_string_literal: true

module Tuka
  module Commands
    class SetCredentials < Thor::Group
      include Bash
      include Thor::Actions

      using CoreExtensions

      def check_prior_setup
        if tukarc_setup?
          puts
          puts 'The required credentials are already set. Setup is unnecessary. Exiting...'
          exit
        end
      rescue StandardError
        clear
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
      rescue TukarcIncompleteVarsError
        rescue_tukarc_incomplete_vars
      rescue TukarcNotLoadedError
        rescue_tukarc_not_loaded
      end

      def display_command_completion
        puts
        puts 'End'
      end

      private

      def rescue_tukarc_missing
        puts '[✓] Created ~/.tukarc'
        TukarcGenerator.new.generate
        prompt_open_tukarc
        prompt_bash_relogin
      end

      def rescue_tukarc_not_loaded
        puts '[✗] The required environment vars are not sourced yet!'
        puts
        puts 'Check if the values in ~/.tukarc are correct.'
        prompt_open_tukarc
        prompt_bash_relogin
      end

      def rescue_tukarc_incomplete_vars
        puts '[✗] Some required environment vars are not set.'
        puts
        puts 'Check if the values in ~/.tukarc are correct.'
        prompt_open_tukarc
        prompt_bash_relogin
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
