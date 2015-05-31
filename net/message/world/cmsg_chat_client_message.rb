require './net/net_message.rb'

module Talia
  module Net
    module Message

      class CMSG_ChatClientMessage < NetMessage
        attr_accessor :channel, :message

        def initialize(packet)
          super()
          packet = packet[2..packet.length - 1]
          @channel = packet.split('|')[0]
          @message = packet.split('|')[1]
        end
      end

    end
  end
end
