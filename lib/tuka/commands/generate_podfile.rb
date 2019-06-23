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
          puts '[✓] Renamed the old Podfile to Podfile.bak'
        end

        def copy_podfile_to_current_dir
          FileUtils.cp(target_generated_podfile_path, Podfile::BASENAME)
          puts '[✓] The generated Podfile has been copied to the current directory and is ready to be used'
          puts
        end

        def run_bundle_pod_install
          puts "[✓] Running 'pod install'"
          podfile.install_via_bundler
        end
      end

      def check_tukafile_existence
        raise StandardError, "No Tukafile found in project directory. Run 'tuka #{Init::USAGE}'" if tukafile.nil?
      end

      def check_tukafile_validity
        raise StandardError, tukafile.error unless tukafile.valid?
      end

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
        @target = project.name
        puts "[✓] Pod target name detected: '#{@target}'"
      end

      def display_add_library_pod
        @library = tukafile.library.name
        @library_path = generated_library.path
        puts "[✓] #{@library} at path '#{@library_path}' will be added to the new #{Podfile::BASENAME}"
      end

      def display_current_pods
        return if podfile.nil?

        @pods = podfile.dependencies(excluded: tukafile.library.name)
        puts "[✓] Other dependencies found in the current Podfile:#{@pods.gsub('  pod', '  ')}"
      end

      def remove_previously_generated_podfile
        return unless target_generated_podfile_path && File.file?(target_generated_podfile_path)

        rm(target_generated_podfile_path)
        puts
        puts '[✓] Deleted previously generated Podfile'
      end

      def generate_podfile
        path = target_generated_podfile_path
        podfile_generator = PodfileGenerator.new(@target, @pods, @library, @library_path, path)
        podfile_generator.swift_version = tukafile.project_info.swift_version
        podfile_generator.generate
      end

      def display_podfile_generated
        puts "[✓] Generated new Podfile at path: '#{target_generated_podfile_path}'"
      end

      def create_new_gemfile
        generate_gemfile
      end

      def display_gemfile_generated
        puts "[✓] Generated a new Gemfile at path: './#{Gemfile::BASENAME}'"
      end

      def execute_bundle_install
        puts
        puts "[✓] Running 'bundle install'..."
        bundle_install
        puts
      end

      def prompt_use_generated_podfile
        yes_option = options[:yes]

        return unless yes_option || yes?("\n[?] Use the generated Podfile? [y|n] ".yellow)

        backup_podfile
        copy_podfile_to_current_dir

        return unless yes_option || yes?("\n[?] Run `pod install`? [y|n] ".yellow)

        puts if yes_option
        run_bundle_pod_install
      end

      def display_command_completion
        puts
        puts 'End' unless options[:quiet]
      end
    end
  end
end
