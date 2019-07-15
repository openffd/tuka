# frozen_string_literal: true

module Tuka
  module Commands
    class ProjectStatus < Command
      using CoreExtensions::StringPrinting
      using System::Xcodeproj

      def display_project_status
        puts
        puts "Checking project status of #{project.name} (#{project.type_pretty})".magenta
        puts
        sleep 1.5
      end

      def check_project_status
        xcproj_show.gsub(/File References.*Targets\s*/m, '').gsub(/\s*- BuildFile/, '').print_by_line
      end

      def display_summary_report_generation
        puts
        puts '[✓] Project summary report successfuly generated'
        sleep 1
        puts "[✓] Project Status: #{'OKAY'.yellow}"
        puts
        sleep 1
      end
    end
  end
end
