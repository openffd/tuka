# frozen_string_literal: true

module Xcodeproj
  Project::Object::PBXGroup.class_eval do
    def has_file_reference?(file_reference)
      files.map { |file| file.path }.include? file_reference
    end

    def add_new_file(path, source_tree = :group)
      new_file(path, source_tree) unless has_file_reference?(path)
    end
  end
end
