require './misc/logger.rb'

module Talia
  module Net

    class NetSession
      attr_accessor :socket

      def initialize(socket)
          @socket = socket
          @logger = Misc::Logger.new(self.class)
          self.wait_data()
      end

      def wait_data()
        Thread.new {
          data = @socket.gets
          data.split('\x00').each do |packet|
            @logger.log("Incoming packet : #{packet}")
          end
        }
      end

      def on_data(data)
        raise "Method need to be implemented"
      end

      def write(packet)
        @socket.puts(packet + "\x00")
      end
    end

  end
end
