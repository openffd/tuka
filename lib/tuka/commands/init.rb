# frozen_string_literal: true

module Tuka
  module Commands
    class Init < Command
      include Credentials
      include Bash

      using CoreExtensions

      no_commands do
        def source_options
          options.keys.map(&:to_sym).reject { |opt| %i[help quiet verbose].include? opt }
        end
      end

      def check_class_options
        raise StandardError, 'Invalid combination of options for this command' if source_options.count > 1
      end

      def display_tuka_setup
        puts
        puts "Initializing a Tukafile for #{project.name} (#{project.type_pretty})".magenta.bold
      end

      def display_tukafile_sourcing
        puts
        puts 'Sourcing Tukafile from this URL: ' + url.yellow
      end

      def source_tukafile_from_git_clone
        return unless source_options.empty? || options[:git_clone]

        raise StandardError, 'Failed to download from given repository URL' unless git_clone(url, TukaBundle::DIR)
      end

      def source_tukafile_from_bitbucket_snippets
        return unless options[:bitbucket]

        # TODO: Try to authenticate using the given credentials and raise an error if unable
        check_bitbucket_credentials

        response = perform_authenticated_curl(url: url, username: Bitbucket::USERNAME, password: Bitbucket::PASSWORD)
        raise StandardError, 'Failed to retrieve Tukafile from given URL' unless response.successful?

        path = File.join(TukaBundle::DIR, Tukafile::BASENAME)
        touch(path: path, content: response.body)
      end

      def source_tukafile_from_curl
        return unless options[:curl]

        response = perform_curl(url: url)
        raise StandardError, 'Failed to retrieve Tukafile from given URL' unless response.code.to_s =~ /20+/

        touch(path: File.join(TukaBundle::DIR, Tukafile::BASENAME), content: response.body)
      end

      def source_tukafile_from_nextcloud
        return unless options[:nextcloud]

        check_nextcloud_credentials

        response = perform_authenticated_curl(url: url, username: Nextcloud::USERNAME, password: Nextcloud::PASSWORD)
        raise StandardError, 'Failed to retrieve Tukafile from given URL' unless response.successful?

        path = File.join(TukaBundle::DIR, Tukafile::BASENAME)
        touch(path: path, content: response.body)
      end

      def source_tukafile_from_local
        return unless options[:local]

        # TODO: Implement sourcing Tukafile from local file system
      end

      def check_downloaded_tukafile
        raise StandardError, 'Unable to locate a Tukafile from the downloaded resource' if tukafile.nil?

        # puts '[] Tukafile downloaded to path: ' + File.join(Dir.pwd, tukafile.path).yellow
        puts '[✓] Tukafile successfully instantiated'
      end

      def edit_tukafile_project_info_xcodeproj
        tukafile.project_info.xcodeproj = xcodeproj_basename
      end

      def edit_tukafile_project_info_type
        tukafile.project_info.type = project.type
      end

      def edit_tukafile_project_info_receptor
        tukafile.project_info.receptor_name = project.name.remove_non_word_chars
      end

      def edit_tukafile_project_info_prefix
        tukafile.project_info.prefix = project.category_prefix
      end

      def check_tukafile_validity
        raise StandardError, tukafile.error unless tukafile.valid?
      end

      def dump_new_tukafile
        tukafile.dump

        puts
        puts '[✓] Pre-configured Tukafile fields to reflect the correct project path and type'
      end

      def display_modified_tukafile_fields
        puts "      - xcodeproj: #{xcodeproj_basename.yellow}"
        puts "      - type     : #{project.type.yellow}"
        puts "      - receptor : #{project.name.remove_non_word_chars.yellow}"
        puts "      - prefix   : #{project.category_prefix}"
      end

      def add_tuka_bundle_to_gitignore
        gitignore_add("#{TukaBundle::DIR}/")

        puts
        puts "[✓] Excluded '#{TukaBundle::DIR}/' from version control"
      end

      def open_tukafile
        puts
        ask '[ Press ENTER to show the Tukafile ]'.yellow
        clear_prev_line
        puts 'Opening the Tukafile...'
        sleep 0.5
        xed(tukafile.path)
        puts
        puts 'You can go ahead and modify the Tukafile fields as necessary.'
      end

      def display_command_completion
        puts
        puts 'End'
      end
    end
  end
end
