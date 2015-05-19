module Talia
  module Misc

    class Logger
      def initialize(name, log = false)
        @name = name
        @log = log
      end

      def log(message)
        puts "[#{@name}] -> #{message}"
      end
    end

  end
end
