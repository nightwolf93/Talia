require 'colorize'

module Talia
  module Misc

    class Logger
      def initialize(name, log = false)
        @name = name
        @log = log
      end

      def log(message)
        puts "[#{@name}]".green + " -> #{message}"
      end

      def error(message)
        puts "[#{@name}]".red + " -> #{message}"
      end

      def debug(message)
        puts "[#{@name}]".magenta + " -> #{message}"
      end
    end

  end
end
