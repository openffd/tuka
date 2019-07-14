# frozen_string_literal: true

module Tuka
  require 'tuka/templates/objc/categories'

  class ReceptorBundle
    include ObjC

    using CoreExtensions
    using CoreExtensions::ObjcFilenameString

    DIR = 'receptor'
    SEARCH_STRING_FILE_NAME = 'Receptor'
    SEARCH_STRING_TARGET = 'XCODETARGET'
    private_constant :SEARCH_STRING_FILE_NAME, :SEARCH_STRING_TARGET

    attr_reader :path, :filename, :category_name

    def initialize(path)
      @path = path
      @filename = 'AppDelegate+Receptor'
      @category_name = 'Receptor'
      @random_categories = categories_sample(5)
    end

    def filename=(new_name)
      rename_files(new_name)
      @filename = new_name
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

    def inject_categories(prefix)
      @random_categories.each_with_index do |category, index|
        category.prefix = prefix
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

    def update_content_receptor_name(receptor_name:)
      files.each { |file| File.open(file).gsub_content(SEARCH_STRING_FILE_NAME, receptor_name) }
    end

    def rename_files(new_name)
      files.each { |file| File.rename(file, file.gsub(category_name, new_name)) }
    end
  end
end
