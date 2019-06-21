# frozen_string_literal: true

module Tuka
  require 'fileutils'

  class Podfile
    attr_reader :path

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
      FileUtils.cp(@path, "#{@path}.bak")
    end

    def install
      system 'pod', 'install'
    end

    def install_via_bundler
      # TODO: You can move this to bundler.rb
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
      [TukaBundle.dir, ProjectBundle::MODDER_DIR] + TukaBundle::PREVIOUS_DIRNAMES
    end
  end
end
