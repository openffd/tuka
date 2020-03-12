# frozen_string_literal: true

module Tuka
  class PodfileGenerator
    TEMPLATES = Dir[File.join(__dir__, '*.erb')]
    DEFAULT_SWIFT_VERSION = '5.0'

    def initialize(path:, target:, dependencies:, library:)
      @path         = path.to_s
      @target       = target.to_s
      @dependencies = dependencies.to_s
      @library      = library.to_s
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
      TEMPLATES.sample
    end
  end
end
