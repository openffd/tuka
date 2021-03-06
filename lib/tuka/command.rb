# frozen_string_literal: true

module Tuka
  class Command < Thor::Group
    include Thor::Actions
    include Git
    include Bundler
    include ProjectBundle
    include TukaBundle
    include Curl::Shortcuts
    include Xcodebuild
    include Tuka::Say

    using CoreExtensions

    class_option :help,     aliases: '-h', type: :boolean, desc: 'Display usage information'
    class_option :quiet,    aliases: '-q', type: :boolean, desc: 'Enable quiet output mode'
    class_option :verbose,  aliases: '-v', type: :boolean, desc: 'Enable verbose output mode'

    no_commands do
      def prlctl
        @prlctl ||= Prlctl::Command.new
      rescue StandardError => _e
        puts
        puts 'The command utility prlctl is not installed in your system.'.red
      end
    end

    def check_shell
      raise StandardError, 'Current shell is not bash' unless `echo $SHELL`.include? 'bash'
    end

    def check_project
      raise StandardError, 'Unable to detect an iOS application project in the current directory' if xcodeproj.nil?
    end

    def clear_appledouble_files
      rm_appledouble_files
    end

    def check_project_type
      raise StandardError, 'Unable to detect the project type' if project.type.nil?
    end

    def check_project_bundle_id
      raise StandardError, 'Unable to detect the project bundle identifier' if project.bundle_id.nil?
    end

    def check_push_notification_capabilities
      message = 'Push notifications not enabled for this project, please go to Capabilities and check the entitlements'
      raise StandardError, message unless project.push_notifications_enabled? || entitlements&.aps_environment_setup?
    end

    def kill_all_vm_xcode
      prlctl.pkill_all_vm_xcode
    end
  end
end
