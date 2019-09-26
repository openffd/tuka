# frozen_string_literal: true

module Tuka
  class Gemfile
    BASENAME = 'Gemfile'

    attr_reader :path

    def initialize(path)
      @path = path
    end
  end

  class GemfileLock
    BASENAME = 'Gemfile.lock'

    attr_reader :path

    def initialize(path)
      @path = path
    end
  end
end
