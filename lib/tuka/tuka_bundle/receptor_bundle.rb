# frozen_string_literal: true

module Tuka
  require 'tuka/templates/objc/categories'

  class InvalidCategoryFilenameError < StandardError
    def initialize(msg = 'Invalid category filename, make sure to not include the extension')
      super(msg)
    end
  end

  class ReceptorBundle
    include ObjC

    using CoreExtensions
    using CoreExtensions::ObjcFilenameString

    DIR = 'receptor'

    INITIAL_RECEPTOR_FILENAME = 'AppDelegate+Receptor'
    INITIAL_RECEPTOR_CATEGORY_NAME = 'Receptor'
    RANDOM_CATEGORIES_SIZE = 5
    SEARCH_STRING_FILE_NAME = 'Receptor'
    SEARCH_STRING_HEADER_FILENAME = 'HEADER_FILENAME'
    SEARCH_STRING_TARGET = 'XCODETARGET'
    private_constant :INITIAL_RECEPTOR_FILENAME,
                     :INITIAL_RECEPTOR_CATEGORY_NAME,
                     :RANDOM_CATEGORIES_SIZE,
                     :SEARCH_STRING_FILE_NAME,
                     :SEARCH_STRING_HEADER_FILENAME,
                     :SEARCH_STRING_TARGET

    attr_reader :path, :prefix, :filename, :category_name

    def initialize(path, prefix, receptor_name)
      @path = path
      @prefix = prefix
      @receptor_name = receptor_name

      @filename = INITIAL_RECEPTOR_FILENAME
      @category_name = INITIAL_RECEPTOR_CATEGORY_NAME
      @category_from_receptor_name = [get_category_with_name(@receptor_name, @prefix)].compact
    end

    def set_filename_from_category

    end

    def filename=(new_name)
      # TODO: Make sure the new filename does not exist in the current iOS project files
      raise InvalidCategoryFilenameError unless new_name.valid_objc_filename?

      rename_files(new_name)
      @filename = new_name
      update_header_importation(new_name)
    end

    def category_name=(new_name)
      update_content_receptor_name(receptor_name: new_name)
      @category_name = new_name
    end

    def h_file
      target_h_file_path if File.file? target_h_file_path
    end

    def m_file
      target_m_file_path if File.file? target_m_file_path
    end

    def files
      [h_file, m_file]
    end

    def update_swift_target(target_name:)
      File.open(h_file).gsub_content(SEARCH_STRING_TARGET, target_name)
    end

    def inject_categories
      @random_categories.each_with_index do |category, index|
        File.open(h_file).gsub_content(%r{//\$#{index}}, category.header_text)
        File.open(m_file).gsub_content(%r{//\$#{index}}, category.implementation_text)
      end
    end

    private

    def target_h_file_path
      File.join(@path, @filename + '.h')
    end

    def target_m_file_path
      File.join(@path, @filename + '.m')
    end

    def random_categories
      @random_categories ||= begin
        additional_size = RANDOM_CATEGORIES_SIZE - @category_from_receptor_name.size
        all = @category_from_receptor_name + categories_sample(additional_size)
        all.each { |category| category.prefix = @prefix }
      end
    end

    def update_content_receptor_name(receptor_name:)
      files.each { |file| File.open(file).gsub_content(SEARCH_STRING_FILE_NAME, receptor_name) }
    end

    def rename_files(new_name)
      files.each { |file| File.rename(file, file.gsub(INITIAL_RECEPTOR_FILENAME, new_name)) }
    end

    def update_header_importation(header_filename)
      File.open(m_file).gsub_content(SEARCH_STRING_HEADER_FILENAME, header_filename)
    end
  end
end
