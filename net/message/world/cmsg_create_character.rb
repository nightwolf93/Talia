require './net/net_message.rb'

module Talia
  module Net
    module Message

      class CMSG_CreateCharacter < NetMessage
        attr_accessor :name, :breed, :gender, :color_1, :color_2, :color_3

        def initialize(packet)
          super()
          data = packet[2..packet.length - 1].split('|')
          @name = data[0]
          @breed = data[1]
          @gender = data[2]
          @color_1 = data[3]
          @color_2 = data[4]
          @color_3 = data[5]
        end
      end

    end
  end
end
