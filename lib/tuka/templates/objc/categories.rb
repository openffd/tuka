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
        @header = File.basename(header)
        @implementation = File.basename(implementation)
        @prefix = DEFAULT_PREFIX
      end

      def filename
        @filename ||= File.basename(@implementation, '.*')
      end

      def prefix=(prefix)
        apply_prefix
        @prefix = prefix
      end

      private

      def apply_prefix(prefix)

      end
    end
  end
end
