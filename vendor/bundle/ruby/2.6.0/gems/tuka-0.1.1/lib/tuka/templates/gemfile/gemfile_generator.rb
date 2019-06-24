# frozen_string_literal: true

module Tuka
  require 'erb'

  class GemfileGenerator
    TEMPLATE = 'gemfile_template.erb'

    def generate
      File.open(Gemfile::BASENAME, 'w+') do |file|
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
