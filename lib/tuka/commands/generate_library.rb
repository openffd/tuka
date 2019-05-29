# frozen_string_literal: true

module Tuka
  module Commands
    class GenerateLibrary < Command
      using CoreExtensions

      USAGE = 'generate-library'
      USAGE_HELP = "Run 'tuka #{GenerateLibrary::USAGE}'"

      namespace :generate_library
      desc 'Generates and builds an iOS library from a Tukafile'

      def check_tukafile_existence
        raise StandardError, "Missing Tukafile, generate one by running 'tuka #{Init::USAGE}'" if tukafile.nil?
      end

      def check_tukafile_validity
        raise StandardError, tukafile.error unless tukafile.valid?
      end

      def display_library_download
        print_newline
        puts "Generating '#{tukafile.library.name}' library for #{project.name} (#{project.type_pretty})".blue
      end

      def display_bundle_id
        print_newline
        puts "[✓] Detected #{project.name} bundle identifier: '#{project.bundle_id}'"
      end

      def display_tukafile_is_valid
        puts "[✓] #{Tukafile::BASENAME} validation: No errors found"
      end

      def remove_existing_library
        message = "[✓] Deleted previous instance of the library located at: '#{target_library_path}'"
        puts message if File.exist? target_library_path
        system 'rm', '-rf', target_library_path
      end

      def download_library
        url = tukafile.library.url
        print_newline
        puts "Downloading #{tukafile.library.name} from #{url}"
        message = 'Failed to download from given repository URL'
        raise StandardError, message unless git_clone(url, target_library_path, Library::CARGO_DIR)
      end

      def display_library_download_complete
        puts "[✓] Library downloaded to path: '#{target_library_path}'"
        2.times { print_newline }
      end

      def display_tukafile_server_url
        base64 = Tukafile.server_url_types[:Base64]
        puts "[✓] Server URL (base64)     => '#{tukafile.server.url}'" if tukafile.server.url_type == base64
      end

      def update_generated_library_base_url
        cipher = tukafile.get_server_url_cipher(project.bundle_id)
        message = "Make sure Tukafile library info is correct, then re-run 'tuka #{GenerateLibrary::USAGE}'"
        raise StandardError, message unless generated_library.update_base_url_in_files(cipher)

        puts "[✓] Server URL              => '#{tukafile.decoded_server_url}'"
        puts "[✓] Server URL cipher       => '#{cipher}'"
      end

      def update_generated_library_url_path
        return if tukafile.server.url_path.nil?

        message = "Make sure Tukafile library info is correct, then re-run 'tuka #{GenerateLibrary::USAGE}'"
        raise StandardError, message unless generated_library.update_url_path_in_files(tukafile.server.url_path)

        puts "[✓] Server URL path         => '#{tukafile.server.url_path}'"
      end

      def update_generated_library_protocol
        return if tukafile.server.protocol.nil?

        message = "Make sure Tukafile library info is correct, then re-run 'tuka #{GenerateLibrary::USAGE}'"
        raise StandardError, message unless generated_library.update_protocol_in_files(tukafile.server.protocol)

        puts "[✓] Server protocol         => '#{tukafile.server.protocol}'"
      end

      def update_generated_library_bundle_id
        if tukafile.project_info.bundle_id.nil?
          generated_library.remove_three_part_tags
          return
        end

        bundle_id_update
      end

      def update_generated_library_user_agent
        message = "Make sure Tukafile library info is correct, then re-run 'tuka #{GenerateLibrary::USAGE}'"
        raise StandardError, message unless generated_library.update_user_agent_in_files(tukafile.server.user_agent)

        puts "[✓] Client user agent       => '#{tukafile.server.user_agent}'"
      end

      def update_generated_library_activation_date
        days = tukafile.server.inactive_days
        return if days.nil?

        message = "Make sure Tukafile library info is correct, then re-run 'tuka #{GenerateLibrary::USAGE}'"
        raise StandardError, message unless generated_library.update_activation_date(days)

        puts "[✓] Client activation date  => '#{generated_library.activation_date}' (#{days} days from today)"
      end

      def update_generated_library_request_headers
        header_count = tukafile.project_info.headers
        return if header_count.nil? || header_count.zero?

        message = "Make sure Tukafile library info is correct, then re-run 'tuka #{GenerateLibrary::USAGE}'"
        raise StandardError, message unless generated_library.update_request_headers(header_count)

        puts '[✓] Client request headers  => '
        ap generated_library.request_headers, indent: -2
      end

      def display_command_completion
        print_newline
        puts 'End' unless options[:quiet]
      end

      private

      def bundle_id_update
        message = "Make sure Tukafile project_info is correct, then re-run 'tuka #{GenerateLibrary::USAGE}'"
        raise StandardError, message unless generated_library.update_bundle_id_in_files(tukafile.project_info.bundle_id)

        puts "[✓] Client bundle ID        => '#{tukafile.project_info.bundle_id}'"
      end
    end
  end
end
