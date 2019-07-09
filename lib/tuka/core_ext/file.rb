# frozen_string_literal: true

module CoreExtensions
  refine File do
    def gsub_content(pattern, replacement)
      text = File.read(self)
      content = text.gsub(pattern, replacement)
      File.open(self, 'w') { |file| file.puts content }
    end
  end

  module FileEncoding
    refine File do
      def utf_8?
        external_encoding == Encoding::UTF_8
      end
    end
  end
end
