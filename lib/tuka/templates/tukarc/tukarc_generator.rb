# frozen_string_literal: true

module Tuka
  require 'erb'

  class TukarcGenerator
    TEMPLATE = 'tukarc_template.erb'

    def generate
      File.open(Bash::TUKARC_PATH, 'w+') do |file|
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
