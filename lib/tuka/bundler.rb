# frozen_string_literal: true

module Tuka
  module Bundler
    def generate_gemfile
      require_relative 'templates/gemfile/gemfile_generator'
      GemfileGenerator.new.generate
    end

    def bundle_install
      system 'bundle', 'install', '--quiet'
    end
  end
end
