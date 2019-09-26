# frozen_string_literal: true

module Tuka
  class Gemfile
    BASENAME = 'Gemfile'
    LOCK = "#{BASENAME}.lock"

    attr_reader :path

    def initialize(path)
      @path = path
    end
  end
end
