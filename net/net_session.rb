require './misc/logger.rb'
require './net/net_message.rb'

module Talia
  module Net

    class NetSession
      attr_accessor :socket

      def initialize(socket)
          @socket = socket
          @active = true
          @logger = Misc::Logger.new(self.class)
          self.wait_data()
      end

      def wait_data()
        Thread.new {
          while @active
            begin
              data = @socket.gets("\0")
              if data != nil
                data = data.chomp
              end
              data = data.gsub("\x0a", "")
              data = data.strip
              data.split('\x00').each do |packet|
                @logger.log("Incoming packet << #{packet}")
                self.on_data(packet)
              end
            rescue Exception => e
              @active = false
              self.on_close
              break
            end
          end
        }
      end

      def on_data(data)
        raise "Method need to be implemented"
      end

      def on_close()
        raise "Method need to be implemented"
      end

      def write(packet, log = true)
        if log
          @logger.log("Send packet >> #{packet}")
        end
        @socket.write(packet + "\x00")
      end

      def write_message(packet)
        data = packet.get_data()
        @logger.log("Send packet >> #{packet.class.name}")
        self.write(data, false)
      end

      def close()

      end
    end

  end
end
