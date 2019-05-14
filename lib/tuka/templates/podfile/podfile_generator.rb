# frozen_string_literal: true

module Tuka
  require 'erb'

  class PodfileGenerator
    DEFAULT_SWIFT_VERSION = '4.2'

    def self.template
      'podfile_template.erb'
    end

    def initialize(target, pods, library, library_path, path)
      @target         = target
      @pods           = pods
      @library        = library
      @library_path   = library_path
      @path           = path
    end

    def swift_version=(version)
      @swift_version = version || DEFAULT_SWIFT_VERSION
    end

    def generate
      File.open(@path, 'w+') do |file|
        text = ERB.new(template).result(binding)
        file.write(text)
      end
    end

    private

    def template
      File.read(template_path)
    end

    def template_path
      File.join(File.expand_path(__dir__), PodfileGenerator.template)
    end
  end
end
