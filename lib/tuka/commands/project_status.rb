# frozen_string_literal: true

module Tuka
  module Commands
    class ProjectStatus < Command
      using CoreExtensions::StringPrinting
      using System::Xcodeproj

      def display_project_status
        puts
        puts "Checking project status of #{project.name} (#{project.type_pretty})".magenta
        sleep 0.8
      end

      def display_summary_report_generation
        puts
        puts "[✓] Project Status: #{'OKAY'.yellow}"
        puts
        puts 'Generating project summary report...'
        sleep 1.5
      end

      def check_project_status
        xcproj_show.gsub(/File References.*Targets\s*/m, '').gsub(/\s*- BuildFile/, '').print_by_line
      end

      def display_command_completion
        puts
        puts 'End' unless options[:quiet]
      end
    end
  end
end
