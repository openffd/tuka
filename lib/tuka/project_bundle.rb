# frozen_string_literal: true

module Tuka
  module ProjectBundle
    using CoreExtensions

    MODDER_DIR = '_atemp'

    def xcodeproj
      @xcodeproj ||= Dir.xcodeprojs.first
    end

    def xcodeproj_basename
      File.basename(xcodeproj)
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

    def receptor_files
      Dir.glob('**/AppDelegate+*.[h|m]')
         .reject { |path| path.include?(TukaBundle.dir) || path.include?(MODDER_DIR) }
    end

    def info_plist
      @info_plist ||= begin
        path = project.info_plist_path unless project.nil?
        InfoPlist.new(path) if path && File.file?(path)
      end
    end

    private

    def target_podfile_path
      Podfile.basename
    end

    def target_gemfile_path
      Gemfile.basename
    end
  end
end
