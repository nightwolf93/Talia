require 'socket'

require './misc/logger.rb'
require './net/net_session.rb'

module Talia
  module Net

    class NetServer
      attr_accessor :host, :port

      def initialize(host, port)
        @server = nil
        @host = host
        @port = port
        @active = true
      end

      def start()
        @server = TCPServer.new @host, @port
        @thread = Thread.new {
          while @active
            socket = @server.accept
            Thread.new {
              self.on_connection(socket)
            }
          end
        }
      end

      def on_connection(socket)
        raise "Method need to be implemented"
        end
    end

  end
end
