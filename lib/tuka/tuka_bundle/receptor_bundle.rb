# frozen_string_literal: true

module Tuka
  class ReceptorBundle
    DIR = 'receptor'
    SEARCH_STRING_FILE_NAME = 'Receptor'
    SEARCH_STRING_TARGET = 'XCODETARGET'
    private_constant :SEARCH_STRING_FILE_NAME, :SEARCH_STRING_TARGET

    attr_reader :path, :category_name

    def initialize(path)
      @path = path
      @category_name = 'Receptor'
    end

    def filename
      "AppDelegate+#{category_name}"
    end

    def category_name=(new_name)
      update_content_receptor_name(receptor_name: new_name)
      update_filename(new_name)
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
      text = File.read(h_file).gsub(SEARCH_STRING_TARGET, target_name)
      File.open(h_file, 'w') { |file| file.puts text }
    end

    private

    def target_h_file_path
      File.join(@path, "#{filename}.h")
    end

    def target_m_file_path
      File.join(@path, "#{filename}.m")
    end

    def update_content_receptor_name(receptor_name:)
      files.each do |receptor_file|
        text = File.read(receptor_file).gsub(SEARCH_STRING_FILE_NAME, receptor_name)
        File.open(receptor_file, 'w') { |file| file.puts text }
      end
    end

    def update_filename(new_name)
      files.each do |file|
        File.rename(file, file.gsub(category_name, new_name))
      end
    end
  end
end
