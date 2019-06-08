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
end
