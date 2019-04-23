# frozen_string_literal: true

module Tuka
  class UserAgent
    DEFAULT = 'Mozilla/5.0 (iPhone; CPU iPhone OS X_X like Mac OS X) AppleWebKit/605.1.6 (KHTML, like Gecko)'\
    'Mobile/15E148'

    def self.default
      DEFAULT
    end

    def self.default(value:)
      DEFAULT.gsub('AppleWebKit/605.1.6', 'AppleWebKit/605.1.' + value.to_i.to_s)
    end
  end
end
