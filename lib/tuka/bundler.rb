# frozen_string_literal: true

module Tuka
  module Bundler
    def generate_gemfile
      GemfileGenerator.new.generate
    end

    def bundle_install
      system 'bundle', 'install'
    end
  end
end
