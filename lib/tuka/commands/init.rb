# frozen_string_literal: true

module Tuka
  module Commands
    class Init < Command
      using CoreExtensions

      USAGE = 'init [URL]'

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
        puts "\nInitializing Tuka for #{project.name} (#{project.type_pretty})".blue
      end

      def download_tukafile
        puts "\nSourcing Tukafile from #{url}"
        if specific_options.empty? || options[:curl]
          # curl = Curl::Easy.new(url)
        elsif options[:git]
          raise StandardError, 'Failed to download from given repository URL' unless git_clone(url, TukaBundle.dir)
        elsif options[:nextcloud]
          curl = Curl::Easy.new(url)
          curl.http_auth_types = :basic
          curl.username = 'username'
          curl.password = 'password123!'
          curl.on_complete  { |curl| puts 'Complete' }
          curl.on_success   { |curl| puts 'Success' }
          curl.perform
        elsif options[:local]
          # TODO: Implement sourcing Tukafile from local file system
        end
      end

      def check_downloaded_tukafile
        raise StandardError, 'Unable to locate the Tukafile from the downloaded repository' if tukafile.nil?

        puts "[✓] Tukafile downloaded to location: '#{tukafile.path}'"
      end

      def modify_tukafile_project_data
        tukafile.project_info.xcodeproj     = xcodeproj_basename
        tukafile.project_info.type          = project.type
        tukafile.project_info.receptor_name = project.name.remove_non_word_chars
      end

      def check_tukafile_validity
        raise StandardError, tukafile.error unless tukafile.valid?
      end

      def dump_new_tukafile
        tukafile.dump
        puts "\n[✓] Modified Tukafile values to reflect project path and type"
      end

      def add_tuka_bundle_to_gitignore
        gitignore("#{TukaBundle.dir}/")
        puts "[✓] Directory '#{TukaBundle.dir}/' is included in .gitignore"
      end

      def open_tukafile
        system 'xed', tukafile.path
      end

      def display_command_completion
        puts "\nEnd"
      end

      private

      def specific_options
        [options[:curl], options[:git], options[:local], options[:nextcloud]].compact
      end
    end
  end
end
