# frozen_string_literal: true

module Tuka
  module Commands
    class GeneratePodfile < Command
      def self.usage
        'generate-podfile'
      end

      namespace :generate_podfile
      desc "Generates a Podfile based on a Tukafile's specifications"
      class_option :yes, aliases: '-y', type: :boolean, desc: 'Auto-selects `yes` option for all prompts'

      def check_tukafile_existence
        raise StandardError, "No Tukafile found in project directory. Run 'tuka #{Init.usage}'" if tukafile.nil?
      end

      def check_tukafile_validity
        raise StandardError, tukafile.error unless tukafile.valid?
      end

      def display_generate_podfile
        puts "\nGenerating a #{Podfile.basename} for #{project.name} (#{project.type_pretty})".blue
      end

      def display_tukafile_is_valid
        puts "\n[✓] Validated the #{Tukafile.basename}"
      end

      def display_pod_target
        @target = project.name
        puts "[✓] Pod target name detected: '#{@target}'"
      end

      def display_add_library_pod
        @library = tukafile.library.name
        @library_path = generated_library.path
        puts "[✓] #{@library} at path '#{@library_path}' will be added to the new #{Podfile.basename}"
      end

      def display_current_pods
        return if podfile.nil?

        @pods = podfile.dependencies(excluded: tukafile.library.name)
        puts "[✓] Other dependencies found in the current Podfile:#{@pods}"
      end

      def remove_previously_generated_podfile
        return unless target_generated_podfile_path && File.file?(target_generated_podfile_path)

        system 'rm', target_generated_podfile_path
        puts "\n[✓] Deleted previously generated Podfile"
      end

      def generate_podfile
        require 'tuka/templates/podfile/podfile_generator'
        path = target_generated_podfile_path
        PodfileGenerator.new(@target, @pods, @library, @library_path, path).generate
      end

      def display_podfile_generated
        puts "[✓] Generated new Podfile at location: '#{target_generated_podfile_path}'"
      end

      def generate_gemfile
        generate_gemfile
      end

      def display_gemfile_generated
        puts "[✓] Generated a new Gemfile at path: ./'#{Gemfile.basename}'"
      end

      def execute_bundle_install
        "[✓] Running 'bundle install'"
        bundle_install
      end

      def prompt_use_generated_podfile
        return unless options[:yes] || yes?("\n[?] Use the generated Podfile? [y|n] ".yellow)

        unless podfile.nil?
          podfile.create_backup
          puts '[✓] Renamed the old Podfile to Podfile.bak'
        end

        FileUtils.cp(target_generated_podfile_path, Podfile.basename)
        puts "[✓] The generated Podfile has been copied to the current directory and is ready to be used\n"

        return unless options[:yes] || yes?("\n[?] Run `pod install`? [y|n] ".yellow)

        puts "\n" if options[:yes]
        puts "[✓] Running 'pod install'"
        podfile.install
      end

      def display_command_completion
        puts "\nEnd" unless options[:quiet]
      end
    end
  end
end
