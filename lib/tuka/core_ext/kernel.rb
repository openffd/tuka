# frozen_string_literal: true

module CoreExtensions
  refine Kernel do
    def touch(filename:, content:)
      File.open(filename, 'w+') { |file| file.puts content }
    end

    def print_newline
      puts "\n"
    end

    def merge_appledouble_files
      system 'dot_clean', '.'
    end
  end
end
