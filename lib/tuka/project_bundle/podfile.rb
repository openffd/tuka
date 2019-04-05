# frozen_string_literal: true

module Tuka
  require 'fileutils'

  class Podfile
    attr_reader :path

    POSSIBLE_DIRS = [TukaBundle.dir, ProjectBundle.modder_dir].freeze
    REQUIRED_DEPENDENCIES = %w[SVProgressHUD MJRefresh].freeze

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

    private

    def strings_to_exclude
      REQUIRED_DEPENDENCIES + POSSIBLE_DIRS
    end
  end
end
