# frozen_string_literal: true

module Tuka
  require 'fileutils'

  class Podfile
    attr_reader :path

    def self.basename
      'Podfile'
    end

    def initialize(path)
      @path = path
    end

    def dependencies(excluded:)
      # TODO: This can be improved
      File.read(@path)
          .scan(/^[^\s\#]*\s*pod\s+(.*)/)
          .reject { |pod| strings_to_exclude.append(excluded).any? { |str| pod.first.include? str } }
          .reduce('') { |total, pod| "#{total}\n  pod #{pod.first}" }
    end

    def create_backup
      FileUtils.cp(@path, "#{@path}.bak")
    end

    def install
      system 'pod', 'install'
    end

    def install_via_bundler
      system 'bundle', 'exec', 'pod', 'install'
    end

    private

    def strings_to_exclude
      required_dependencies + possible_dirs
    end

    def required_dependencies
      %w[SVProgressHUD MJRefresh]
    end

    def possible_dirs
      TukaBundle.previous_dir_names.append TukaBundle.dir, ProjectBundle.modder_dir
    end
  end
end
