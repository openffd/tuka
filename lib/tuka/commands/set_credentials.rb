# frozen_string_literal: true

module Tuka
  module Commands
    class SetCredentials < Thor::Group
      include Bash

      using CoreExtensions

      def display_credentials_setup
        print_newline
        puts 'Service Credentials Setup for Tuka'.magenta
      end

      def check_prior_setup
        # if tukarc && bash_profile &&
        puts 'Looks like credentials have been setup already.' unless tukarc.nil? || bash_profile.nil?
      end

      def create_tukarc
        puts 'Unable to locate a `.tukarc` file in the home directory. Creating one...' if tukarc.nil?
      end

      # def check_bash_profile_existence
      #   if bash_profile.nil?
      # end
    end
  end
end
