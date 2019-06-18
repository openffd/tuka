# frozen_string_literal: true

module Tuka
  class ObjcFileGroup
    def initialize(header:, implementation:)
      @header = header
      @implementation = implementation
    end
  end
end
