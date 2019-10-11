# frozen_string_literal: true

module Tuka
  module Prlctl
    using System

    COMMAND = 'prlctl'
    VM = OpenStruct

    class PrlctlCmdNotFoundError < StandardError
      def initialize(msg = 'Command not found: ' + COMMAND)
        super(msg)
      end
    end

    def ls_running_vms
      check_prlctl

      `#{COMMAND} list -j`
    end

    private

    def check_prlctl
      raise PrlctlCmdNotFoundError if cmd_not_found?(COMMAND)
    end
  end
end
