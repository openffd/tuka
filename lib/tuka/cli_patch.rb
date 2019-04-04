# frozen_string_literal: true

module Tuka
  class CLI
    class << self
      def help(shell, subcommand = false)
        list = printable_commands(true, subcommand)
        Thor::Util.thor_classes_in(self).each do |klass|
          list += klass.printable_commands(false)
        end
        list.reject! { |item| item[0].split[1] == 'help' }.each do |item|
          item[0].gsub! 'tuka ', ''
          item[1].gsub! '# ', '  '
        end

        shell.say "\nJust another automation tool for the iOS developers of YJN.", :magenta
        shell.say "\nUsage:", :yellow
        shell.say '  tuka [OPTIONS] [COMMAND]'
        shell.say "\nCommands:", :yellow

        shell.print_table(list, indent: 2, truncate: true)
        shell.say "\nRun 'tuka -h [COMMAND]' for more information on a command.", :yellow
      end
    end
  end
end
