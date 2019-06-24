# frozen_string_literal: true

module Tuka
  module Bundler
    COMMAND = 'bundle'

    def generate_gemfile
      GemfileGenerator.new.generate
    end

    def bundle_install
      system COMMAND, 'install'
    end

    def bundle_exec(*args)
      system COMMAND, 'exec', *args
    end
  end
end
