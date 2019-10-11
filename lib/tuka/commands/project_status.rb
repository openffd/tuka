# frozen_string_literal: true

module Tuka
  module Commands
    class ProjectStatus < Command
      using CoreExtensions::StringPrinting
      using System::Xcodeproj

      def display_project_status
        message = "Checking project status of #{project.name} (#{project.type_pretty})"
        puts
        puts message.magenta
        # say_with_voice(tukafile.decoded_auth.to_s + ', I am' + message) if options[:verbose]
      end

      def check_project_status
        puts
        sleep 1.5
        xcproj_show.gsub(/File References.*Targets\s*/m, '').gsub(/\s*- BuildFile/, '').print_by_line
      end

      def display_summary_report_generation
        puts
        puts '[✓] Project summary report successfuly generated'
        sleep 1
      end

      def display_project_status_okay
        puts "[✓] Project Status: #{'OKAY'.yellow}"
        puts
        sleep 1
      end
    end
  end
end
