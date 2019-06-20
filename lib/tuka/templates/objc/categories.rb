# frozen_string_literal: true

module Tuka
  module ObjC
    def category_files(type:)
      Dir[File.join(__dir__, '**', type.to_s, '*.*')]
    end

    class Category
      def initialize(header:, implementation:)
        @header = header
        @implementation = implementation
      end
    end
  end
end
