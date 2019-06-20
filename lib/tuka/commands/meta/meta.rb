# frozen_string_literal: true

module Tuka
  module Commands
    class AddGitignore < Command
      USAGE = 'add-gitignore'

      namespace :add_gitignore
      desc 'Adds a pre-configured Gitignore file to an iOS project'
    end

    class Init < Command
      USAGE = 'init URL [OPTIONS]'

      namespace :init
      desc 'Downloads a pre-configured Tukafile from the given URL'
      argument :url

      class_option :bitbucket,  aliases: ['-b'], desc: 'Source the Tukafile from a private Bitbucket snippet/raw file'
      class_option :curl,       aliases: ['-c'], desc: 'Uses unauthenticated cURL to instantiate the Tukafile'
      class_option :git_clone,  aliases: ['-g'], desc: 'Clones a remote Git repository and extracts the Tukafile'
      class_option :nextcloud,  aliases: ['-n'], desc: 'Sources the Tukafile from a Nextcloud file server'
      # class_option :local,      aliases: ['-l'], desc: 'Copy a Tukafile from the local file system'
    end

    class GenerateLibrary < Command
      USAGE = 'generate-library'
      USAGE_HELP = "Run 'tuka #{GenerateLibrary::USAGE}'"

      namespace :generate_library
      desc 'Generates and builds an iOS library from a Tukafile'
    end

    class GeneratePodfile < Command
      USAGE = 'generate-podfile'

      namespace :generate_podfile
      desc 'Generates a Podfile with the specified dependencies/hooks'
      class_option :yes, aliases: '-y', type: :boolean, desc: 'Auto-selects `yes` option for all prompts'
    end

    class GenerateReceptor < Command
      USAGE = 'generate-receptor'

      namespace :generate_receptor
      desc 'Generates receptor files to be added to an iOS project'
    end

    class Install < Command
      USAGE = 'install'

      namespace :install
      desc 'Automagically installs all Tuka components to an iOS project'
    end

    class SetCredentials < Thor::Group
      USAGE = 'set-credentials'

      namespace :set_credentials
      desc 'Lets you setup credentials for services needed by Tuka (e.g. Bitbucket)'
    end

    class Uninstall < Command
      USAGE = 'uninstall'

      namespace :uninstall
      desc 'Removes Tuka related files and settings from an iOS project'
    end
  end
end
