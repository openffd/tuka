# frozen_string_literal: true

module Tuka
  class CLI
    class << self
      def help(shell, subcommand = false)
        shell.say "\nYet another automation tool for Yeojinet iOS Developers", :blue
        shell.say "\nUsage:", :yellow
        shell.say '  tuka COMMAND [ARG] [OPTIONS]'
        shell.say "\nCommands:", :yellow
        shell.print_table(cmd_list(subcommand), indent: 2, truncate: true)
        shell.say "\nHelp:", :yellow
        shell.say "  Run 'tuka -h COMMAND' for more information on a command."
      end

      def cmd_list(subcommand)
        list = printable_commands(true, subcommand)
        Thor::Util.thor_classes_in(self).each do |klass|
          list += klass.printable_commands(false)
        end
        list.reject! { |item| item[0].split[1] == 'help' }.each do |item|
          item[0].gsub! 'tuka ', ''
          item[1].gsub! '# ', '  '
        end
      end
    end
  end
end
