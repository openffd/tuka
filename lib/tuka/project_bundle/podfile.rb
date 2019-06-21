# frozen_string_literal: true

module Tuka
  require 'fileutils'

  class Podfile
    include Bundler

    attr_reader :path

    COMMAND = 'pod'
    BASENAME = 'Podfile'

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
      # TODO: Save other backups to have a complete backup history
      FileUtils.cp(@path, "#{@path}.bak")
    end

    def install
      system COMMAND, 'install'
    end

    def install_via_bundler
      bundle_exec(COMMAND, 'install')
    end

    private

    def strings_to_exclude
      required_dependencies + possible_dirs
    end

    def required_dependencies
      %w[SVProgressHUD MJRefresh]
    end

    def possible_dirs
      [TukaBundle.dir, ProjectBundle::MODDER_DIR] + TukaBundle::PREVIOUS_DIRNAMES
    end
  end
end
