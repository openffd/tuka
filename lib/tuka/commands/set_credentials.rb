# frozen_string_literal: true

module Tuka
  module Commands
    class SetCredentials < Thor::Group
      include Bash

      using CoreExtensions

      def display_credentials_setup
        print_newline
        puts 'Initializing Service Credentials Setup for Tuka...'.magenta
      end

      def check_prior_setup
        lambda {
          print_newline
          puts "The required credentials are already set. There's no need for a setup. Exiting..."
          exit
        }.call if tukarc_setup?
      rescue
      end

      def check_bash_profile
        print_newline
        puts '[✓] Checked `~/.bash_profile`: OK' if bash_profile_setup?
      rescue BashProfileTukarcNotSourcedError
        puts '[✓] Detected `~/.bash_profile`; Added lines to source the `~/.tukarc` file.'
        add_line_sourcing_tukarc_to_bash_profile
      rescue BashProfileMissingError
        puts '[✓] Created `~/.bash_profile`'
        create_bash_profile
      end

      def create_tukarc
        puts 'Unable to locate a `.tukarc` file in the home directory. Creating one...' if tukarc.nil?
      end
    end
  end
end
