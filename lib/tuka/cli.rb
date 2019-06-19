# frozen_string_literal: true

module Tuka
  class CLI < Thor
    C = Commands

    using CoreExtensions

    update_library_usage  = 'update-library'
    update_library_desc   = 'Updates previously generated library as per new Tukafile configuration'
    update_podfile_usage  = 'update-podfile'
    update_podfile_desc   = 'Updates previously generated podfile as per new Tukafile configuration'
    update_receptor_usage = 'update-receptor'
    update_receptor_desc  = 'Updates previously generated receptors as per new Tukafile configuration'

    # TODO: Meta this in the future
    register C::Init,             'init',               C::Init::USAGE,             C::Init.desc
    register C::Install,          'install',            C::Install::USAGE,          C::Install.desc
    register C::GenerateLibrary,  'generate_library',   C::GenerateLibrary::USAGE,  C::GenerateLibrary.desc
    register C::GeneratePodfile,  'generate_podfile',   C::GeneratePodfile::USAGE,  C::GeneratePodfile.desc
    register C::GenerateReceptor, 'generate_receptor',  C::GenerateReceptor::USAGE, C::GenerateReceptor.desc
    register C::GenerateLibrary,  'update_library',     update_library_usage,       update_library_desc
    register C::GeneratePodfile,  'update_podfile',     update_podfile_usage,       update_podfile_desc
    register C::GenerateReceptor, 'update_receptor',    update_receptor_usage,      update_receptor_desc
    register C::SetCredentials,   'set_credentials',    C::SetCredentials::USAGE,   C::SetCredentials.desc
    register C::Uninstall,        'uninstall',          C::Uninstall::USAGE,        C::Uninstall.desc
    register C::AddGitignore,     'add_gitignore',      C::AddGitignore::USAGE,     C::AddGitignore.desc

    desc 'merge-files', 'Merges double files'
    method_option :help, type: :string, aliases: ['-h']
    def merge_files
      if options[:help]
        invoke :help, [__method__]
        return
      end

      merge_appledouble_files

      puts
      puts 'Double files merged.'
    end

    desc 'powerup!', "Let's power up!"
    method_option :help, type: :string, aliases: ['-h']
    def powerup!
      if options[:help]
        invoke :help, [__method__]
        return
      end

      system "echo \"LET'S POWERUP!\" | lolcat -F 1 -a -d 12 -s 11; echo '(╯°□°）╯︵ ┻━┻' | lolcat -F 1 -a -d 12 -s 11"
    end

    desc 'version', 'Show the Tuka version information'
    method_option :help, type: :string, aliases: ['-h']
    def version
      if options[:help]
        invoke :help, [__method__]
        return
      end

      puts 'v' + VERSION
    end

    map %w[gitignore add-gi addg ag] => :add_gitignore
    map %w[generate-lib update-lib gen-lib genlib gl ul] => :generate_library
    map %w[generate-pod update-pod gen-pod genpod gp up] => :generate_podfile
    map %w[generate-rcp update-rcp gen-rcp genrcp gr ur] => :generate_receptor
    map %w[install i] => :install
    map %w[setcreds creds setc sc] => :set_credentials
    map %w[rm u] => :uninstall
    map %w[pow] => :powerup!
    map %w[mf] => :merge_files
    map %w[--version -v] => :version
  end
end
