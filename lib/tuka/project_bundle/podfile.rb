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
          .reject { |pod| required_dependencies.append(excluded).include? pod.first }
          .reject { |pod| pod.first.include? TukaBundle.dir }
          .reject { |pod| pod.first.include? ProjectBundle.modder_dir }
          .reduce('') { |total, pod| "#{total}\n  pod #{pod.first}" }
    end

    def create_backup
      FileUtils.cp(@path, "#{@path}.bak")
    end

    def install
      system 'pod', 'install'
    end

    private

    def required_dependencies
      %w[SVProgressHUD MJRefresh]
    end
  end
end
