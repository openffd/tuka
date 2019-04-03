# frozen_string_literal: true

module Tuka
  class CLI < Thor
    desc 'version', 'Show the Tuka version information'
    def version
      puts "v#{VERSION}"
    end

    generate_library = Commands::GenerateLibrary
    generate_podfile = Commands::GeneratePodfile

    register Commands::Init,        'init',             Commands::Init.usage,         Commands::Init.desc
    register generate_library,      'generate_library', generate_library.usage,       generate_library.desc
    register generate_podfile,      'generate_podfile', generate_podfile.usage,       generate_podfile.desc
    register Commands::AddReceptor, 'add_receptor',     Commands::AddReceptor.usage,  Commands::AddReceptor.desc
    register Commands::Automatic,   'automatic',        Commands::Automatic.usage,    Commands::Automatic.desc
    register Commands::Uninstall,   'uninstall',        Commands::Uninstall.usage,    Commands::Uninstall.desc

    desc 'powerup!', "Let's power up!"
    def powerup!
      puts "\n(╯°□°）╯︵ ┻━┻"
    end

    map %w[generate-lib update-lib gen-lib genlib gl ul] => :generate_library
    map %w[generate-pod update-pod gen-pod genpod gp up] => :generate_podfile
    map %w[add-recep add-r addr ar] => :add_receptor
    map %w[install auto au a] => :automatic
    map %w[rm u] => :uninstall
    map %w[pow] => :powerup!
    map %w[--version -v] => :version
  end
end
