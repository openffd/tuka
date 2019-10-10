# frozen_string_literal: true

module Bundler
  class GemHelper
    DIR = '$HOME/.gems'

    def install_gem(built_gem_path = nil, local = false)
      built_gem_path ||= build_gem
      out, _ = sh_with_code("gem install '#{built_gem_path}'#{" --local" if local} --install-dir #{DIR} --no-document")
      error_message = "Couldn't install gem, run `gem install #{built_gem_path}' for more detailed output"
      raise error_message unless out[/Successfully installed/]
      Bundler.ui.confirm "#{name} (#{version}) installed."
    end
  end
end
