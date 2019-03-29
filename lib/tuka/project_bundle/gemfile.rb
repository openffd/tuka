# frozen_string_literal: true

module Tuka
  class Gemfile
    attr_reader :path

    def self.basename
      'Gemfile'
    end

    def initialize(path)
      @path = path
    end
  end
end
