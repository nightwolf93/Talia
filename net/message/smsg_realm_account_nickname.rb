require './net/net_message.rb'

module Talia
  module Net
    module Message

      class SMSG_RealmAccountNickname < NetMessage
        attr_accessor :nickname

        def initialize(nickname)
          super('Ad')
          @nickname = nickname
        end

        def build()
          @buffer = @nickname
        end
      end

    end
  end
end
