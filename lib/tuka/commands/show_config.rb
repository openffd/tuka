# frozen_string_literal: true

module Tuka
  module Commands
    using CoreExtensions

    class ShowConfig < Command
      def display_show_config
        puts
        puts "Locating Tuka config file for #{project.name} (#{project.type_pretty})...".magenta
        puts
      end

      def check_tukafile
        raise StandardError, 'Tukafile not found' unless tuka_bundle_dir && File.file?(generated_tukafile_path)
      end

      def open_config
        puts 'Opening the Tukafile...'
        open_file(generated_tukafile_path)
      end
    end
  end
end
