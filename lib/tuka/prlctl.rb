# frozen_string_literal: true

module Tuka
  module Prlctl
    using CoreExtensions::SubCommand

    VM = OpenStruct
    CMD = 'prlctl'
    LS_SUBCMD = %w(list exec).as_same_keyval_hash

    class CmdNotFoundError < StandardError
      def initialize(msg = 'Command not found: ' + CMD)
        super(msg)
      end
    end

    class VM
      LS_STATUS = %w(running stopped).as_same_keyval_hash

      def running?
        status.eql?(LS_STATUS[:running])
      end

      def pkill_xcode
        system("#{CMD} #{LS_SUBCMD[:exec]} #{uuid} pkill Xcode") if running?
      end
    end

    class Command
      using System

      def initialize
        raise CmdNotFoundError if cmd_not_found?(CMD)
      end

      def pkill_all_vm_xcode
        ls_running_vms.each { |vm| vm.pkill_xcode }
      end

      private

      def ls_running_vms
        eval(`#{CMD} #{LS_SUBCMD[:list]} -j`).to_a.map(&VM.method(:new))
      end
    end
  end
end
