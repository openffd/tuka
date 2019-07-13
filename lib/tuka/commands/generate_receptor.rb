# frozen_string_literal: true

module Tuka
  module Commands
    class GenerateReceptor < Command
      using CoreExtensions
      using System

      no_commands do
        def add_bridging_header
          bridging_header = File.join(@bridges_source_path, BridgingHeader::BASENAME)
          FileUtils.cp(bridging_header, project.new_file_destination_group.path)
          project.register_bridging_header(bridging_header)
        end
      end

      def check_tukafile_existence
        raise StandardError, "No Tukafile found in project directory. Run 'tuka #{Init::USAGE}'" if tukafile.nil?
      end

      def check_tukafile_validity
        raise StandardError, tukafile.error unless tukafile.valid?
      end

      def check_library_existence
        message = "Unable to locate a generated #{tukafile.library.name} library. "
        raise StandardError, message + GenerateLibrary::USAGE_HELP if generated_library.nil?
      end

      def check_library_receptor_existence
        message = "Missing receptor directory/files from the generated #{tukafile.library.name} library. "
        @receptor_source_path = File.join(generated_library.target_receptors_path, tukafile.project_info.type)
        raise StandardError, message + GenerateLibrary::USAGE_HELP if Dir.glob("#{@receptor_source_path}/*").count != 2
      end

      def check_library_bridges_existence
        message = "Missing bridge files from the generated #{tukafile.library.name} library. "
        @bridges_source_path = File.join(generated_library.target_bridges_path)
        raise StandardError, message + GenerateLibrary::USAGE_HELP if Dir.glob("#{@bridges_source_path}/*").empty?
      end

      def display_generate_receptor
        puts
        puts "Generating Receptor files for #{project.name} (#{project.type_pretty})".magenta
      end

      def display_project_state_checking
        puts
        puts 'Checking current project status...'
      end

      def display_xcode_info
        puts "[✓] Detected installed Xcode version: #{xcode_info.yellow}"
      end

      def display_tukafile_is_valid
        puts "[✓] #{Tukafile::BASENAME} validation: " + '0 errors found'.yellow
      end

      def display_tukafile_receptor
        puts "[✓] Detected Tukafile receptor name: #{tukafile.project_info.receptor_name.yellow}"
      end

      def delete_previous_receptor
        return if receptor_bundle.nil?

        rm_rf(receptor_bundle.path)
        puts '[✓] Deleted previously generated receptor files'
      end

      def instantiate_receptor_files
        Dir.mkdir File.join(tuka_bundle_dir, ReceptorBundle::DIR)
        FileUtils.cp_r("#{@receptor_source_path}/.", receptor_bundle.path)
      end

      def check_instantiated_receptor_files
        message = 'Unable to instantiate the receptor files. '
        raise StandardError, message + GenerateLibrary::USAGE_HELP if receptor_bundle.files.length < 2
      end

      def display_receptor_files_preparation
        puts
        puts 'Creating and preparing the Receptor files...'
        puts '[✓] Receptor files initialized'
      end

      def update_receptor_target_for_swift
        return unless project.swift?

        receptor_bundle.update_swift_target(target_name: project.name)
        puts '[✓] Set correct Swift project target for receptor files'
      end

      def prepare_receptor_content
        require 'pry'
        binding.pry
        receptor_bundle.inject_categories(tukafile.project_info.prefix)
      end

      def update_receptor_name
        return if tukafile.project_info.receptor_name.nil?

        receptor_bundle.category_name = tukafile.project_info.receptor_name
        puts '[✓] Receptor files renamed to: ' + "#{receptor_bundle.filename}.*".yellow
      end

      def delete_previous_receptor_files
        project.delete_previous_receptor_files
      end

      def add_receptor_files_to_project
        FileUtils.cp_r("#{receptor_bundle.path}/.", project.new_file_destination_group.path)
        project.add_new_receptor_files(h_file: receptor_bundle.h_file, m_file: receptor_bundle.m_file)
      end

      def display_adding_receptor_files_to_project
        path = project.new_file_destination_group.path
        puts "[✓] Receptor files added to #{project.name} at path: " + "#{path}/".yellow
      end

      def display_other_project_status_checking
        puts
        puts 'Performing other necessary checks...'
      end

      def display_push_notifications_enabled
        puts '[✓] Push notifications: ' + 'enabled'.yellow # This was checked earlier
      end

      def add_user_notifications_framework
        return unless project.unity?

        if project.contains_user_notifications_framework?
          puts '[✓] UserNotifications.framework is already in Linked Frameworks and Libraries'
        else
          project.add_user_notifications_framework
          puts '[✓] Added UserNotifications.framework to Linked Frameworks and Libraries'
        end
      end

      def embed_swift_standard_libraries
        project.always_embed_swift_standard_libraries
        puts '[✓] Embedded Swift standard libraries'
      end

      def add_swift_project_bridging_header
        return unless project.swift?

        path = project.bridging_header
        return if File.file? path.to_s

        add_bridging_header
        puts '[✓] Added a bridging header'
      end

      def setup_project_app_transport_settings
        info_plist.set_allows_arbitrary_loads
        puts '[✓] App Transport Settings set to allow arbitrary loads'
      end

      def display_command_completion
        puts
        puts 'End' unless options[:quiet]
      end
    end
  end
end
