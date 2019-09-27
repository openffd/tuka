# frozen_string_literal: true

module Tuka
  module Bundler
    COMMAND = 'bundle'

    def generate_gemfile
      GemfileGenerator.new.generate
    end

    def bundle_install
      `#{COMMAND} install`
    end

    def bundle_exec(*args)
      system COMMAND, 'exec', *args
    end

    def bundle_update(gem_name)
      system COMMAND, 'update', gem_name
    end
  end
end
