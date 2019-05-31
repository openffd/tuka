# frozen_string_literal: true

module Tuka
  require 'erb'

  class GitignoreGenerator
    TEMPLATE = 'gitignore_template.erb'

    def initialize(pattern)
      @pattern = pattern
    end

    def generate
      File.open(GITIGNORE_BASENAME, 'w+') do |file|
        text = ERB.new(template).result(binding)
        file.write(text)
      end
    end

    private

    def template
      File.read(template_path)
    end

    def template_path
      File.join(File.expand_path(__dir__), TEMPLATE)
    end
  end
end
