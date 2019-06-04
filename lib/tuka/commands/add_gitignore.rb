# frozen_string_literal: true

module Tuka
  module Commands
    class AddGitignore < Command
      using CoreExtensions

      def check_gitignore_existence
        raise StandardError, 'A gitignore file already exists.' if File.file? GITIGNORE_BASENAME
      end

      def display_addition_of_gitignore
        print_newline
        puts "Generating a Gitignore file for #{project.name} (#{project.type_pretty})".magenta
      end

      def create_gitignore
        gitignore_add
      end

      def show_gitignore
        print_newline
        puts 'Opening the gitignore...'

        sleep 0.5
        xed(GITIGNORE_BASENAME)
      end

      def display_command_completion
        print_newline
        puts 'End' unless options[:quiet]
      end
    end
  end
end
