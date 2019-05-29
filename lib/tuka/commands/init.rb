# frozen_string_literal: true

module Tuka
  module Commands
    class Init < Command
      using CoreExtensions

      USAGE = 'init [URL] [OPTIONS]'

      namespace :init
      desc 'Downloads a pre-configured Tukafile from the given URL'
      argument :url
      class_option :curl,       aliases: ['-c'], desc: 'Use cURL to instantiate the Tukafile'
      class_option :git,        aliases: ['-g'], desc: 'Download the Tukafile from a remote Git repository'
      class_option :nextcloud,  aliases: ['-n'], desc: 'Source Tukafile from a Nextcloud file server'
      # class_option :local,      aliases: ['-l'], desc: 'Copy a Tukafile from the local file system'

      def check_class_options
        raise StandardError, 'Invalid combination of options for this command' if specific_options.count > 1
      end

      def display_tuka_setup
        print_newline
        puts "Initializing a Tukafile for #{project.name} (#{project.type_pretty})".blue
      end

      def display_tukafile_sourcing
        print_newline
        puts 'Sourcing Tukafile from URL: ' + url.yellow
      end

      def source_tukafile_from_curl
        return unless specific_options.empty? || options[:curl]

        response = perform_curl(url: url)
        raise StandardError, 'Failed to retrieve Tukafile from given URL' unless response.code.to_s =~ /20+/

        touch(filename: File.join(TukaBundle.dir, Tukafile::BASENAME), content: response.body)
      end

      def source_tukafile_from_git
        return unless options[:git]

        raise StandardError, 'Failed to download from given repository URL' unless git_clone(url, TukaBundle.dir)
      end

      def source_tukafile_from_nextcloud
        return unless options[:nextcloud]

        response = perform_curl_with_auth(url: url)
        raise StandardError, 'Failed to retrieve Tukafile from given URL' unless response.code.to_s =~ /20+/

        touch(filename: File.join(TukaBundle.dir, Tukafile::BASENAME), content: response.body)
      end

      def source_tukafile_from_local
        return unless options[:local]

        # TODO: Implement sourcing Tukafile from local file system
      end

      def check_downloaded_tukafile
        raise StandardError, 'Unable to locate a Tukafile from the downloaded resource' if tukafile.nil?

        puts '[✓] Tukafile downloaded to path: ' + File.join(Dir.pwd, tukafile.path).yellow
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

      def check_tukafile_validity
        raise StandardError, tukafile.error unless tukafile.valid?
      end

      def dump_new_tukafile
        tukafile.dump

        print_newline
        puts '[✓] Pre-configured Tukafile fields to reflect project path and type'
      end

      def display_modified_tukafile_fields
        puts "    project_info: {\n      xcodeproj => '#{xcodeproj_basename}'".yellow
        puts "      type      => '#{project.type}'".yellow
        puts "      receptor  => '#{project.name.remove_non_word_chars}'".yellow
        puts '    }'.yellow
      end

      def add_tuka_bundle_to_gitignore
        gitignore_add("#{TukaBundle.dir}/")

        print_newline
        puts "[✓] Added directory '#{TukaBundle.dir}/' to .gitignore"
      end

      def open_tukafile
        system 'xed', tukafile.path
      end

      def display_command_completion
        print_newline
        puts 'End'
      end

      private

      def specific_options
        [options[:curl], options[:git], options[:local], options[:nextcloud]].compact
      end
    end
  end
end
