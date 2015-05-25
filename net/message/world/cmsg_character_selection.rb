require './net/net_message.rb'

module Talia
  module Net
    module Message

      class CMSG_CharacterSelection < NetMessage
        attr_accessor :id

        def initialize(packet)
          super()
          @id = packet[2..packet.length - 1]
        end
      end

    end
  end
end
