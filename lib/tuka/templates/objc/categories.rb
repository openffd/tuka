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
        @header_text = File.open(header).read.gsub(/^.*(#import|@import) .*$/, '')
        @implementation_text = File.open(implementation).read.gsub(/^.*(#import|@import) .*$/, '')
      end

      def filename
        @filename ||= File.basename(@implementation, '.*')
      end

      def prefix=(prefix)
        raise StandardError, 'Invalid category prefix' unless prefix =~ /^[[:alpha:]]{3,5}$/

        apply_prefix(prefix)
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

    def get_category_with_name(category_name, prefix)
      category_file_group = get_category_file(category_name, prefix)
      return nil if category_file_group.nil?

      category = Category.new(header: category_file_group.first, implementation: category_file_group.last)
      category.prefix = prefix
      category
    end

    private

    def get_category_file(filename, prefix)
      result = category_files.select do |file|
        filename == File.basename(file.first, '.*').sub(Category::DEFAULT_PREFIX, prefix)
      end
      result.first
    end

    def category_files(file_type: nil, framework: nil)
      all = Dir[File.join(__dir__, '**', framework.to_s, "*.#{file_type || '{h,m}'}")]
      all.group_by { |file| File.basename(file, '.*').itself }.values.map(&:sort)
    end
  end
end
