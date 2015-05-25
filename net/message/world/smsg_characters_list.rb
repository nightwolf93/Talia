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
          @buffer += @subscribe_remaining.to_s + "|" + @characters.length.to_s
          for $c in @characters
            @buffer += "|#{$c.id};#{$c.nickname};#{$c.level};#{$c.get_default_look};#{$c.color_1};#{$c.color_2};#{$c.color_3};,,,,,;0;1;0;0;"
          end
          puts @buffer
        end
      end

    end
  end
end
