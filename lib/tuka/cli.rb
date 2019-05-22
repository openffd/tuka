# frozen_string_literal: true

module Tuka
  class CLI < Thor
    generate_library = Commands::GenerateLibrary
    generate_podfile = Commands::GeneratePodfile
    update_library_desc = 'Updates a previously generated library from a Tukafile'

    register Commands::Init,        'init',             Commands::Init::USAGE,         Commands::Init.desc
    register Commands::Automatic,   'automatic',        Commands::Automatic.usage,    Commands::Automatic.desc
    register generate_library,      'generate_library', generate_library::USAGE,        generate_library.desc
    register generate_library,      'update_library',   'update-library',             update_library_desc
    register generate_podfile,      'generate_podfile', generate_podfile.usage,       generate_podfile.desc
    register Commands::AddReceptor, 'add_receptor',     Commands::AddReceptor::USAGE,   Commands::AddReceptor.desc
    register Commands::Uninstall,   'uninstall',        Commands::Uninstall.usage,    Commands::Uninstall.desc

    desc 'powerup!', "Let's power up!"
    def powerup!
      system "echo \"LET'S POWERUP!\" | lolcat -F 1 -a -d 12 -s 11; echo '(╯°□°）╯︵ ┻━┻' | lolcat -F 1 -a -d 12 -s 11"
    end

    desc 'version', 'Show the Tuka version information'
    def version
      puts "v#{VERSION}"
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
