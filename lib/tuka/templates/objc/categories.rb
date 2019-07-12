# frozen_string_literal: true

module Tuka
  module ObjC
    def category_files(file_type: nil, framework: nil)
      all = Dir[File.join(__dir__, '**', framework.to_s, "*.#{file_type || '{h,m}'}")]
      all.group_by { |file| File.basename(file, '.*').itself }.values
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
