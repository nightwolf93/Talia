require './net/net_message.rb'

module Talia
  module Net
    module Message

      class SMSG_CharacterSelection < NetMessage
        attr_accessor :character

        def initialize(character)
          super('ASK')

          @character = character
        end

        def build()
          @buffer += "|#{@character.id}|#{@character.nickname}|#{@character.level}|#{@character.breed_id}|#{@character.get_default_look}|"
          @buffer += "#{@character.color_1}|#{@character.color_2}|#{@character.color_3}|||"
        end
      end

    end
  end
end
