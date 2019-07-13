# frozen_string_literal: true

module Tuka
  module ObjC
    class Category
      DEFAULT_PREFIX = 'MXBZ'

      attr_reader :header, :implementation, :framework, :prefix, :header_content, :implementation_content

      def initialize(header:, implementation:)
        @header = header
        @implementation = implementation
        @framework = File.basename(Pathname.new(implementation).parent)
        @prefix = DEFAULT_PREFIX
        @header_content = File.open(header).read
        @implementation_content = File.open(implementation).read
      end

      def filename
        @filename ||= File.basename(@implementation, '.*')
      end

      def prefix=(prefix)
        raise StandardError, 'Invalid category prefix' unless prefix.match(/^[[:alpha:]]{3,5}$/)
        apply_prefix
        @prefix = prefix
      end

      private

      def apply_prefix(prefix)
        @header_content.gsub!(DEFAULT_PREFIX, prefix)
      end
    end

    def categories_sample(count = 1)
      samples = [] + category_files.sample(count)
      samples.map { |sample| Category.new(header: sample.first, implementation: sample.last) }
    end

    private

    def category_files(file_type: nil, framework: nil)
      all = Dir[File.join(__dir__, '**', framework.to_s, "*.#{file_type || '{h,m}'}")]
      all.group_by { |file| File.basename(file, '.*').itself }.values
    end
  end
end
