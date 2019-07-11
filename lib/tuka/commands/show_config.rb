# frozen_string_literal: true

module Tuka
  module Commands
    class ShowConfig < Command
      def display_show_config
        puts
        puts "Locating Tuka config file for #{project.name} (#{project.type_pretty})".magenta
      end

      def open_config
        path = tukafile.path
        xed(path) if path
      end
    end
  end
end
