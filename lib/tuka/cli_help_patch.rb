# frozen_string_literal: true

module Tuka
  class CLI < Thor
    class << self
      def help(shell, subcommand = false)
        list = printable_commands(true, subcommand)
        Thor::Util.thor_classes_in(self).each do |klass|
          list += klass.printable_commands(false)
        end
        list.reject! { |list| list[0].split[1]  == 'help' }

        shell.say "\nJust another automation tool for the iOS developers of YJN.", :magenta
        shell.say "\nCommands:", :cyan

        shell.print_table(list, :indent => 2, :truncate => true)
        shell.say
        class_options_help(shell)

        shell.say "Run 'tuka -h [COMMAND]' for more information on a command.", :cyan
      end
    end
  end
end
