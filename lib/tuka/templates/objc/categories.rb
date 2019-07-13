# frozen_string_literal: true

module Tuka
  module ObjC
    class Category
      DEFAULT_PREFIX = 'MXBZ'

      attr_reader :header, :implementation, :framework, :prefix, :header_text, :implementation_text

      def initialize(header:, implementation:)
        @header = header
        @implementation = implementation
        @framework = File.basename(Pathname.new(implementation).parent)
        @prefix = DEFAULT_PREFIX
        @header_text = File.open(header).read
        @implementation_text = File.open(implementation).read
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
        @header_text =
          @header_text
          .gsub(@prefix.upcase, prefix.upcase)
          .gsub(@prefix.downcase, prefix.downcase)
        @implementation_text =
          @implementation_text
          .gsub(@prefix.upcase, prefix.upcase)
          .gsub(@prefix.downcase, prefix.downcase)
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
