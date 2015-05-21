require './net/net_message.rb'

module Talia
  module Net
    module Message

      class SMSG_RealmTicket < NetMessage
        attr_accessor :ticket

        def initialize(server_host, server_port, ticket)
          super('AYK')
          @server_host = server_host
          @server_port = server_port
          @ticket = ticket
        end

        def build()
          @buffer = "#{@server_host}:#{@server_port};#{@ticket}"
        end
      end

    end
  end
end
