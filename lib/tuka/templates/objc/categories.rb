# frozen_string_literal: true

module Tuka
  module ObjC
    def category_files(type: nil)
      Dir[File.join(__dir__, '**', type.to_s, '*.{h,m}')]
    end

    class Category
      DEFAULT_PREFIX = 'MXBZ'

      def initialize(header:, implementation:)
        @header = header
        @implementation = implementation
      end
    end
  end
end
