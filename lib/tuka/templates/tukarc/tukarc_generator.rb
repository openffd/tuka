# frozen_string_literal: true

module Tuka
  class TukarcGenerator
    TEMPLATE = 'tukarc_template.erb'

    def generate
      File.open(File.expand_path(Bash::TUKARC_PATH), 'w+') do |file|
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
