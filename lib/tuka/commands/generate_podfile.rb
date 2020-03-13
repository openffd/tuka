# frozen_string_literal: true

module Tuka
  module Commands
    class GeneratePodfile < Command
      using CoreExtensions
      using System

      no_commands do
        def backup_podfile
          return if podfile.nil?

          podfile.create_backup
          puts '[✓] Renamed the old Podfile to ' + 'Podfile.bak'.yellow
        end

        def copy_podfile_to_current_dir
          FileUtils.cp(generated_podfile_path, Podfile::BASENAME)
          puts '[✓] The generated Podfile has been copied to the current directory and is ready to be used'
          puts
        end

        def run_bundle_pod_install
          bundle_update('cocoapods')

          podfile.deintegrate
          podfile.install_via_bundler
        end

        def dependencies
          @dependencies ||= podfile.dependencies(excluded: tukafile.library.name)
        end

        def podfile_generator
          @podfile_generator ||= PodfileGenerator.new(
            path: generated_podfile_path,
            target: project.name,
            dependencies: dependencies,
            library: tukafile.library.name
          )
        end
      end

      def kill_all_vm_xcode
        prlctl.pkill_all_vm_xcode
      end

      def check_tukafile_existence
        raise StandardError, "No Tukafile found in project directory. Run 'tuka #{Init::USAGE}'" if tukafile.nil?
      end

      def check_tukafile_validity
        raise StandardError, tukafile.error unless tukafile.valid?
      end

      # def check_tukafile_receptor_name
      #   receptor_name = tukafile.project_info.receptor_name
      #   return if receptor_name.nil?

      #   raise StandardError, 'Invalid Tukafile receptor_name' unless project.validate_receptor_name?(receptor_name)
      # end

      def display_generate_podfile
        puts
        puts "Generating a #{Podfile::BASENAME} for #{project.name} (#{project.type_pretty})".magenta
      end

      def display_xcode_info
        puts
        puts "[✓] Detected installed Xcode version: #{xcode_info.yellow}"
      end

      def display_tukafile_is_valid
        puts "[✓] #{Tukafile::BASENAME} validation: " + '0 errors found'.yellow
      end

      def display_pod_target
        puts "[✓] Pod target name detected: #{project.name.yellow}"
      end

      def display_add_library_pod
        puts "[✓] Added the generated #{tukafile.library.name} to the new #{Podfile::BASENAME}"
      end

      def display_current_pods
        return if podfile.nil?

        puts "[✓] Other dependencies found in the current Podfile:#{dependencies.gsub('  pod', '  ').yellow}"
      end

      def remove_previously_generated_podfile
        return unless File.file? generated_podfile_path.to_s

        rm(generated_podfile_path)
        puts
        puts '[✓] Deleted previously generated Podfile'
      end

      def generate_podfile
        podfile_generator.swift_version = tukafile.project_info.swift_version
        podfile_generator.generate
      end

      def display_podfile_generated
        puts '[✓] New Podfile successfully generated'
      end

      def delete_gemfile_lock
        return unless gemfile_lock

        gemfile_lock.delete
        puts
        puts '[✓] Deleted previously generated Gemfile.lock'
      end

      def create_new_gemfile
        generate_gemfile
        puts '[✓] Generated a new Gemfile'
      end

      def display_running_bundle_install
        puts
        puts '[✓] Running bundle install'
      end

      def execute_bundle_install
        out = bundle_install
        puts out
        if out =~ /`#{Bundler::COMMAND} update cocoapods`/
          puts '[✓] Bundler will update cocoapods'
          bundle_update('cocoapods')
        end
        puts
      end

      def prompt_use_generated_podfile
        yes_option = options[:yes]
        return unless yes_option || yes?("\n[?] Use the generated Podfile? [y|n] ".yellow)

        backup_podfile
        copy_podfile_to_current_dir

        return unless yes_option || yes?("\n[?] Run `pod install`? [y|n] ".yellow)

        puts if yes_option
        puts '[✓] Installing dependencies from the current Podfile'
        run_bundle_pod_install
      end

      def display_command_completion
        puts
        puts 'End' unless options[:quiet]
      end
    end
  end
end
