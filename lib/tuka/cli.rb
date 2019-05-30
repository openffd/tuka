# frozen_string_literal: true

module Tuka
  class CLI < Thor
    generate_library    = Commands::GenerateLibrary
    generate_podfile    = Commands::GeneratePodfile
    generate_receptor   = Commands::GenerateReceptor

    update_library_usage  = 'update-library'
    update_library_desc   = 'Updates previously generated library according to new Tukafile configuration'

    update_podfile_usage  = 'update-podfile'
    update_podfile_desc   = 'Updates previously generated podfile according to new Tukafile configuration'

    update_receptor_usage = 'update-receptor'
    update_receptor_desc  = 'Updates previously generated receptors according to new Tukafile configuration'

    register Commands::Init,      'init',               Commands::Init::USAGE,          Commands::Init.desc
    register Commands::Automatic, 'automatic',          Commands::Automatic::USAGE,     Commands::Automatic.desc
    register generate_library,    'generate_library',   generate_library::USAGE,        generate_library.desc
    register generate_podfile,    'generate_podfile',   generate_podfile::USAGE,        generate_podfile.desc
    register generate_receptor,   'generate_receptor',  generate_receptor::USAGE,       generate_receptor.desc
    register generate_library,    'update_library',     update_library_usage,           update_library_desc
    register generate_podfile,    'update_podfile',     update_podfile_usage,           update_podfile_desc
    register generate_receptor,   'update_receptor',    update_receptor_usage,          update_receptor_desc
    register Commands::Uninstall, 'uninstall',          Commands::Uninstall::USAGE,     Commands::Uninstall.desc

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
    map %w[generate-rcp update-rcp gen-rcp genrcp gr ur] => :generate_receptor
    map %w[automatic install auto au a] => :automatic
    map %w[rm u] => :uninstall
    map %w[pow] => :powerup!
    map %w[--version -v] => :version
  end
end
