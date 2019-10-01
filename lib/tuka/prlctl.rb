# frozen_string_literal: true

module Tuka
  module Prlctl
    COMMAND = 'prlctl'

    class PrlctlCmdNotFoundError < StandardError
      def initialize(msg = 'Command not found: ' + COMMAND)
        super(msg)
      end
    end

    def ls_running_vms
      raise PrlctlCmdNotFoundError if cmd_not_found?

      `#{COMMAND} list -j`
    end

    private

    def cmd_not_found?
      system(COMMAND).nil?
    end
  end
end
