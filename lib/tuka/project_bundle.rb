# frozen_string_literal: true

module Tuka
  module ProjectBundle
    using CoreExtensions

    def xcodeproj
      @xcodeproj ||= Dir.xcodeprojs.first
    end

    def project
      @project ||= Project.new(xcodeproj) if xcodeproj
    end

    def podfile
      @podfile ||= Podfile.new(target_podfile_path) if File.file? target_podfile_path
    end

    def gemfile
      @gemfile ||= Gemfile.new(target_gemfile_path) if File.file? target_gemfile_path
    end

    def info_plist
      @info_plist ||= begin
        path = project.info_plist_path unless project.nil?
        InfoPlist.new(path) if File.file? path.to_s
      end
    end

    private

    def target_podfile_path
      Podfile::BASENAME
    end

    def target_gemfile_path
      Gemfile::BASENAME
    end
  end
end
