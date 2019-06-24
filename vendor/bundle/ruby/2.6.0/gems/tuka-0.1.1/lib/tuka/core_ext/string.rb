# frozen_string_literal: true

module CoreExtensions
  require 'resolv'
  require 'base64'

  refine String do
    def remove_non_word_chars
      gsub(/(\W|\d)/, '')
    end

    def ipv4?
      self =~ Resolv::IPv4::Regex
    end

    def base64?
      decoded = Base64.decode64(self)
      Base64.encode64(decoded).include? self
    end

    def url?
      prepend('http://') unless start_with? 'http://'
      self =~ URI::DEFAULT_PARSER.regexp[:ABS_URI]
    end

    def cipher_charset
      ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    end

    def rot_cipher(seed, charset = cipher_charset)
      chars.map do |char|
        if charset.include? char
          charset[(charset.find_index(char) + seed % charset.count) % charset.count]
        else
          char
        end
      end.join
    end
  end

  module StringPrefix
    refine String do
      def remove_non_letter_chars
        gsub(/[^a-z]*/i, '')
      end

      def generate_prefix
        return self if size <= 3

        trail_size = [1].concat([2] * 10, [3] * 10).sample
        start_index = (1..size - trail_size).to_a.sample
        prefix = self[0] + self[start_index, trail_size].to_s
        prefix
      end
    end
  end
end
