require 'socket'
require './misc/logger.rb'

module Talia
  module Net

    class RealmServer
      def initialize()
        @logger = Misc::Logger.new(self.class)
        @server = nil
      end

      def start()
        @server = TCPServer.new '127.0.0.1', 444
        @thread = Thread.new {
          socket = @server.accept
        }
      end
    end

  end
end
