require './net/net_message.rb'

module Talia
  module Net
    module Message

      class CMSG_RealmAuthentificationRequest < NetMessage
        attr_accessor :username, :password

        def initialize(packet)
          super()
          @username = packet.split('#')[0]
          @password = packet.split('#')[1]
          @password = @password[1..@password.length - 1]
        end
      end

    end
  end
end
