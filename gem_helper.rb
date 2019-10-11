# frozen_string_literal: true

module Bundler
  class GemHelper
    DIR = '$HOME/.gems'

    def install_gem(built_gem_path = nil, local = false, serve = false)
      built_gem_path ||= build_gem
      cmd = "gem install '#{built_gem_path}'#{" --local" if local}"
      cmd += " --install-dir #{DIR} --no-document" if serve
      out, _ = sh_with_code(cmd)
      error_message = "Couldn't install gem, run `gem install #{built_gem_path}' for more detailed output"
      raise error_message unless out[/Successfully installed/]
      Bundler.ui.confirm "#{name} (#{version}) installed."
    end

    def install
      built_gem_path = nil

      task 'build' do
        built_gem_path = build_gem
      end

      task 'install' => 'build' do
        install_gem(built_gem_path)
      end

      task 'install:serve' => 'build' do
        install_gem(built_gem_path, false, true)
      end
    end
  end
end
