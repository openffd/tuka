# frozen_string_literal: true

module Tuka
  module Commands
    class GenerateLibrary < Command
      using CoreExtensions
      using System

      no_commands do
        def bundle_id_update
          bundle_id = tukafile.project_info.bundle_id
          message = "Make sure Tukafile project_info is correct, then re-run 'tuka #{GenerateLibrary::USAGE}'"
          raise StandardError, message unless generated_library.update_bundle_id_in_files(bundle_id)

          puts "[✓] Client bundle ID        => #{bundle_id.yellow}"
        end
      end

      def check_tukafile_existence
        raise StandardError, "Missing Tukafile, generate one by running 'tuka #{Init::USAGE}'" if tukafile.nil?
      end

      def check_tukafile_validity
        raise StandardError, tukafile.error unless tukafile.valid?
      end

      def display_library_download
        puts
        puts "Generating '#{tukafile.library.name}' library for #{project.name} (#{project.type_pretty})".magenta
      end

      def display_xcode_info
        puts
        puts "[✓] Detected installed Xcode version: #{xcode_info.yellow}"
      end

      def display_bundle_id
        puts "[✓] Detected #{project.name} bundle identifier: #{project.bundle_id.yellow}"
      end

      def display_tukafile_is_valid
        puts "[✓] #{Tukafile::BASENAME} validation: " + '0 errors found'.yellow
      end

      def remove_existing_library
        message = '[✓] Deleted previous instance of the library'
        puts message if File.exist? generated_library_path
        rm_rf(generated_library_path)
      end

      def download_library
        url = tukafile.library.url
        puts
        puts "Downloading #{tukafile.library.name} from #{url.yellow}..."
        message = 'Failed to download from given repository URL'
        raise StandardError, message unless git_clone(url, generated_library_path)
      end

      def display_library_download_complete
        puts '[✓] Successfully instantiated the library'
        puts
      end

      def display_library_modifications
        puts 'Initializing library configurations...'
      end

      def display_tukafile_server_url
        puts "[✓] Server URL (base64)     => #{tukafile.server.url.yellow}" if tukafile.server.url_type.base64?
      end

      def update_generated_library_base_url
        cipher = tukafile.get_server_url_cipher(project.bundle_id)
        message = "Make sure Tukafile library info is correct, then re-run 'tuka #{GenerateLibrary::USAGE}'"
        raise StandardError, message unless generated_library.update_base_url_in_files(cipher)

        puts "[✓] Server URL              => #{tukafile.decoded_server_url.yellow}"
        puts "[✓] Server URL cipher       => #{cipher.yellow}"
      end

      def update_generated_library_url_path
        url_path = tukafile.server.url_path
        return if url_path.nil?

        message = "Make sure Tukafile library info is correct, then re-run 'tuka #{GenerateLibrary::USAGE}'"
        raise StandardError, message unless generated_library.update_url_path_in_files(url_path)

        puts "[✓] Server URL path         => #{url_path.yellow}"
      end

      def update_generated_library_protocol
        protocol = tukafile.server.protocol
        return if protocol.nil?

        message = "Make sure Tukafile library info is correct, then re-run 'tuka #{GenerateLibrary::USAGE}'"
        raise StandardError, message unless generated_library.update_protocol_in_files(protocol)

        puts "[✓] Server protocol         => #{protocol.yellow}"
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

        puts "[✓] Client user agent       => #{tukafile.server.user_agent.to_s.yellow}"
      end

      def update_generated_library_activation_date
        days = tukafile.server.inactive_days
        return if days.nil?

        message = "Make sure Tukafile library info is correct, then re-run 'tuka #{GenerateLibrary::USAGE}'"
        raise StandardError, message unless generated_library.update_activation_date(days)

        puts "[✓] Client activation date  => #{generated_library.activation_date.yellow} (#{days} days from today)"
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
        puts
        puts 'End' unless options[:quiet]
      end
    end
  end
end
