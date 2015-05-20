require 'socket'

require './misc/logger.rb'
require './net/net_session.rb'

module Talia
  module Net

    class NetServer
      attr_accessor :port

      def initialize(port)
        @server = nil
        @port = port
      end

      def start()
        @server = TCPServer.new '127.0.0.1', @port
        @thread = Thread.new {
          socket = @server.accept
        }
      end

      def on_connection(socket)
        raise "Method need to be implemented"
        end
    end

  end
end
