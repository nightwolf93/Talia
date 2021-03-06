require './net/net_message.rb'

module Talia
  module Net
    module Message

      class CMSG_AuthentificationTicket < NetMessage
        attr_accessor :ticket

        def initialize(packet)
          super()
          @ticket = packet[2..packet.length - 1]
        end
      end

    end
  end
end
