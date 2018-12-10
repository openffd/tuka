# frozen_string_literal: true

module Tuka
  class Receptor
    def self.dir
      'receptor'
    end

    def self.receptor_name_search_string
      'Receptor'
    end

    def self.receptor_target_search_string
      'XCODETARGET'
    end

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
      text = File.read(h_file).gsub(Receptor.receptor_target_search_string, target_name)
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
        text = File.read(receptor_file).gsub(Receptor.receptor_name_search_string, receptor_name)
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
