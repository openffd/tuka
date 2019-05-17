# frozen_string_literal: true

module Tuka
  module Commands
    class AddReceptor < Command
      def self.usage
        'add-receptor'
      end

      namespace :add_receptor
      desc 'Adds generated receptor files to an iOS project'

      def check_tukafile_existence
        raise StandardError, "No Tukafile found in project directory. Run 'tuka #{Init.usage}'" if tukafile.nil?
      end

      def check_tukafile_validity
        raise StandardError, tukafile.error unless tukafile.valid?
      end

      def check_library_existence
        message = "Unable to locate a generated #{tukafile.library.name} library. "
        raise StandardError, message + GenerateLibrary.usage_help if generated_library.nil?
      end

      def check_library_receptor_existence
        message = "Missing receptor directory/files from the generated #{tukafile.library.name} library. "
        @receptor_source_path = File.join(generated_library.target_receptors_path, tukafile.project_info.type)
        raise StandardError, message + GenerateLibrary.usage_help if Dir.glob("#{@receptor_source_path}/*").count != 2
      end

      def check_library_bridges_existence
        message = "Missing bridge files from the generated #{tukafile.library.name} library. "
        @bridges_source_path = File.join(generated_library.target_bridges_path)
        raise StandardError, message + GenerateLibrary.usage_help if Dir.glob("#{@bridges_source_path}/*").empty?
      end

      def display_generate_podfile
        puts "\nAdding Receptor files to #{project.name} (#{project.type_pretty})".blue
      end

      def display_project_state_checking
        puts "\nChecking current project status..."
      end

      def display_tukafile_is_valid
        puts "[✓] #{Tukafile.basename} validation: No errors found"
      end

      def display_tukafile_receptor
        puts "[✓] Detected Tukafile receptor name: '#{tukafile.project_info.receptor_name}'"
      end

      def delete_previous_receptor
        return if receptor.nil?

        system 'rm', '-rf', receptor.path
        puts "[✓] Deleted previous receptor files found in '#{tuka_bundle_dir}'"
      end

      def instantiate_receptor_files
        Dir.mkdir File.join(tuka_bundle_dir, Receptor.dir)
        FileUtils.cp_r("#{@receptor_source_path}/.", receptor.path)

        message = 'Unable to instantiate the receptor files. '
        raise StandardError, message + GenerateLibrary.usage_help if receptor.h_file.nil? && receptor.m_file.nil?
      end

      def display_receptor_files_preparation
        puts "\nCreating and preparing the Receptor files..."
      end

      def display_receptor_files_generated
        puts "[✓] Receptor files initialized at path: '#{receptor.path}'"
      end

      def update_receptor_target_for_swift
        return unless project.type == Project.types[:Swift]

        receptor.update_swift_target(target_name: project.name)
        puts '[✓] Set correct Swift project target for receptor files'
      end

      def update_receptor_name
        return if tukafile.project_info.receptor_name.nil?

        receptor.category_name = tukafile.project_info.receptor_name
        puts "[✓] Receptor files renamed to: '#{receptor.filename}.*'"
      end

      def delete_previous_receptor_files
        project.delete_previous_receptor_files
      end

      def add_receptor_files_to_project
        FileUtils.cp_r("#{receptor.path}/.", project.new_file_destination_group.path)
        project.add_new_receptor_files(h_file: receptor.h_file, m_file: receptor.m_file)
        puts "[✓] Receptor files added to #{project.name} at path: '#{project.new_file_destination_group.path}/'"
      end

      def display_other_project_status_checking
        puts "\nPerforming other necessary checks..."
      end

      def display_push_notifications_enabled
        puts '[✓] Push notifications is enabled' # This was checked earlier
      end

      def add_user_notifications_framework
        return unless project.type == Project.types[:Unity]

        if project.contains_user_notifications_framework?
          puts '[✓] UserNotifications.framework is already in Linked Frameworks and Libraries'
        else
          project.add_user_notifications_framework
          puts '[✓] Added UserNotifications.framework to Linked Frameworks and Libraries'
        end
      end

      def embed_swift_standard_libraries
        project.always_embed_swift_standard_libraries
        puts '[✓] Swift standard libraries embedded'
      end

      def add_swift_project_bridging_header
        return unless project.type == Project.types[:Swift]

        path = project.bridging_header
        return unless path.nil? || !File.file?(path)

        bridging_header = File.join(@bridges_source_path, BridgingHeader::BASENAME)
        FileUtils.cp(bridging_header, project.new_file_destination_group.path)
        project.register_bridging_header(bridging_header)
        puts '[✓] Added a bridging header'
      end

      def setup_project_app_transport_settings
        info_plist.set_allows_arbitrary_loads
        puts '[✓] App Transport Settings allow arbitrary loads'
      end

      def display_command_completion
        puts "\nEnd" unless options[:quiet]
      end
    end
  end
end
