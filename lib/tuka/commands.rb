# frozen_string_literal: true

module Tuka
  module Commands
    require_relative 'commands/meta/meta'
    require_relative 'commands/add_gitignore'
    require_relative 'commands/generate_library'
    require_relative 'commands/generate_podfile'
    require_relative 'commands/generate_receptor'
    require_relative 'commands/init'
    require_relative 'commands/install'
    require_relative 'commands/project_status'
    require_relative 'commands/set_credentials'
    require_relative 'commands/uninstall'
  end
end
