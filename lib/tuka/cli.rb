# frozen_string_literal: true

module Tuka
  class CLI < Thor
    _ = Commands

    using CoreExtensions

    update_library_usage  = 'update-library'
    update_library_desc   = 'Updates previously generated library as per new Tukafile configuration'
    update_podfile_usage  = 'update-podfile'
    update_podfile_desc   = 'Updates previously generated podfile as per new Tukafile configuration'
    update_receptor_usage = 'update-receptor'
    update_receptor_desc  = 'Updates previously generated receptors as per new Tukafile configuration'

    # TODO: Meta this in the future
    register _::Init,             'init',               _::Init::USAGE,             _::Init.desc
    register _::Install,          'install',            _::Install::USAGE,          _::Install.desc
    register _::GenerateLibrary,  'generate_library',   _::GenerateLibrary::USAGE,  _::GenerateLibrary.desc
    register _::GeneratePodfile,  'generate_podfile',   _::GeneratePodfile::USAGE,  _::GeneratePodfile.desc
    register _::GenerateReceptor, 'generate_receptor',  _::GenerateReceptor::USAGE, _::GenerateReceptor.desc
    register _::GenerateLibrary,  'update_library',     update_library_usage,       update_library_desc
    register _::GeneratePodfile,  'update_podfile',     update_podfile_usage,       update_podfile_desc
    register _::GenerateReceptor, 'update_receptor',    update_receptor_usage,      update_receptor_desc
    register _::SetCredentials,   'set_credentials',    _::SetCredentials::USAGE,   _::SetCredentials.desc
    register _::Uninstall,        'uninstall',          _::Uninstall::USAGE,        _::Uninstall.desc
    register _::AddGitignore,     'add_gitignore',      _::AddGitignore::USAGE,     _::AddGitignore.desc

    desc 'merge-files', 'Merges double files'
    def merge_files
      merge_appledouble_files

      print_newline
      puts 'Double files merged.'
    end

    desc 'powerup!', "Let's power up!"
    def powerup!
      system "echo \"LET'S POWERUP!\" | lolcat -F 1 -a -d 12 -s 11; echo '(╯°□°）╯︵ ┻━┻' | lolcat -F 1 -a -d 12 -s 11"
    end

    desc 'version', 'Show the Tuka version information'
    def version
      puts 'v' + VERSION
    end

    map %w[gitignore add-gi addg ag] => :add_gitignore
    map %w[generate-lib update-lib gen-lib genlib gl ul] => :generate_library
    map %w[generate-pod update-pod gen-pod genpod gp up] => :generate_podfile
    map %w[generate-rcp update-rcp gen-rcp genrcp gr ur] => :generate_receptor
    map %w[install i] => :install
    map %w[rm u] => :uninstall
    map %w[pow] => :powerup!
    map %w[mf] => :merge_files
    map %w[--version -v] => :version
  end
end
