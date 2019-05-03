# frozen_string_literal: true

module Tuka
  module RequestHeader
    ALL_HEADERS = {
      :accept_charset                   => 'Accept-Charset',
      :access_control_allow_credentials => 'Access-Control-Allow-Credentials',
      :accept_encoding                  => 'Accept-Encoding',
      :accept_language                  => 'Accept-Language',
      :age                              => 'Age',
      :cache_control                    => 'Cache-Control',
      :clear_site_data                  => 'Clear-Site-Data',
      :connection                       => 'Connection',
      :dnt                              => 'DNT',
      :expect                           => 'Expect',
      :retry_after                      => 'Retry-After',
      :te                               => 'TE',
      :tk                               => 'TK',
    }.freeze

    def generate_request_headers(count = 0)
      ALL_HEADERS.to_a.sample(count).map { |key, val| Hash(val => send(key)) }.inject :merge
    end

    private

    def accept_charset
      ['iso-8859-1', 'utf-8', '*'].sample
    end

    def access_control_allow_credentials
      true
    end

    def accept_encoding
      ['compress', 'gzip', 'deflate', 'identity', '*'].sample
    end

    def accept_language
      ['en-US', 'fr-CA', 'da', 'de-CH', 'en-GB'].sample(4).join(', ')
    end

    def age
      (0..24).to_a.sample
    end

    def cache_control
      ['must-revalidate', 'no-cache', 'no-store', 'public', 'private', 'no-transform'].sample
    end

    def clear_site_data
      ['cache', 'cookies', 'storage'].sample
    end

    def connection
      ['keep-alive', 'close'].sample
    end

    def dnt
      [0, 1].sample
    end

    def expect
      ['100-continue'].sample
    end

    def retry_after
      (1..4).to_a.sample
    end

    def te
      ['compress', 'deflate', 'gzip', 'trailers'].sample
    end

    def tk
      ['!', '?', 'G', 'N', 'T', 'C', 'P', 'D', 'U'].sample
    end
  end
end
