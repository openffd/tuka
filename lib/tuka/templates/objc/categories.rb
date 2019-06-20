# frozen_string_literal: true

module Tuka
  module ObjC
    def category_files
      require 'pry'
      binding.pry
    end

    class Category
      def initialize(header:, implementation:)
        @header = header
        @implementation = implementation
      end
    end
  end
end
