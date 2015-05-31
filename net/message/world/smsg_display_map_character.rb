require './net/net_message.rb'

module Talia
  module Net
    module Message

      class SMSG_DisplayMapCharacter < NetMessage
        attr_accessor :map

        def initialize(characters)
          super('GM')

          @characters = characters
        end

        def build()
          @characters.each do |session|
            c = session.character
            var1 = (c.id + c.level).to_s
            @buffer += "|+#{c.cell_id};#{c.orientation_id};0;#{c.id};#{c.nickname};#{c.breed_id};#{c.get_default_look}^100;#{c.gender};,#{var1};"
            @buffer += "#{c.color_1.hex};#{c.color_2.hex};#{c.color_3.hex};;;;;;0;;"
          end
          puts @buffer
        end
      end

    end
  end
end
