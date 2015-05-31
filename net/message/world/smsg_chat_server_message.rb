require './net/net_message.rb'

module Talia
  module Net
    module Message

      class SMSG_ChatServerMessage < NetMessage
        attr_accessor :character, :message

        def initialize(character, message)
          super('cMK')

          @character = character
          @message = message
        end

        def build()
          @buffer += "|#{@character.id}|#{@character.nickname}|#{@message}"
        end
      end

    end
  end
end
