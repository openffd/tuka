# frozen_string_literal: true

module Tuka
  module Commands
    require_relative 'commands/init'
    require_relative 'commands/generate_library'
    require_relative 'commands/generate_podfile'
    require_relative 'commands/add_receptor'
    require_relative 'commands/automatic'
    require_relative 'commands/uninstall'
  end
end
