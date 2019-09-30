# frozen_string_literal: true

module CoreExtensions
  refine Kernel do
    def touch(path:, content:)
      File.open(path, 'w+') { |file| file.puts content }
    end

    def append_to_file(path, string:)
      File.open(path, 'a') { |file| file.puts string }
    end

    def clear
      system 'clear'
    end

    def clear_prev_line
      print "\r\e[A\e[K"
    end

    def blinking_message(msg, blink_count: 10)
      blink_count.times do
        print "\r#{msg}"
        sleep 0.5
        print "\r#{' ' * msg.size}"
        sleep 0.5
      end
      print msg
    end

    def open_file(path)
      `open #{path}`
    end

    def xed(path)
      `xed #{path}`
    end

    def merge_appledouble_files
      system 'dot_clean', '.'
    end

    def rm_appledouble_files(path = '.')
      system "find #{path} -name ._* -exec rm {} \\;"
    end
  end
end
