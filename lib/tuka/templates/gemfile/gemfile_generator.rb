# frozen_string_literal: true

module Tuka
  require 'erb'

  class GemfileGenerator
    def self.template
      'gemfile_template.erb'
    end

    def generate
      File.open(Gemfile.basename, 'w+') do |file|
        text = ERB.new(template).result(binding)
        file.write(text)
      end
    end

    private

    def template
      File.read(template_path)
    end

    def template_path
      File.join(File.expand_path(__dir__), GemfileGenerator.template)
    end
  end
end
