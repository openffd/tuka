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

    def contents
      File.read(@path)
    end

    def dependencies(excluded:)
      contents
        .scan(/^[^\s\#]*\s*pod\s+(.*)/)
        .reject { |pod| pod.first.include? excluded }
        .reduce('') { |total, pod| "#{total}\n  pod #{pod.first}" }
    end

    def create_backup
      FileUtils.cp(@path, "#{@path}.bak")
    end

    def install
      system 'pod', 'install'
    end
  end
end
