# frozen_string_literal: true

module CoreExtensions
  refine Kernel do
    # TODO: Change filename to path
    def touch(filename:, content:)
      File.open(filename, 'w+') { |file| file.puts content }
    end

    def append_to_file(path, string:)
      File.open(path, 'a') { |file| file.puts string }
    end

    def clear
      system 'clear'
    end

    def open_file(path)
      system 'open', path
    end

    def xed(path)
      system 'xed', path
    end

    def print_newline
      puts "\n"
    end

    def merge_appledouble_files
      system 'dot_clean', '.'
    end
  end
end
