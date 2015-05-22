require './net/net_message.rb'

module Talia
  module Net
    module Message

      class SMSG_CharactersList < NetMessage
        attr_accessor :subscribe_remaining, :characters

        def initialize(subscribe_remaining, characters)
          super('ALK')

          @subscribe_remaining = subscribe_remaining
          @characters = characters
        end

        def build()
          @buffer = @subscribe_remaining
        end
      end

    end
  end
end
