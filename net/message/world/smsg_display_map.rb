require './net/net_message.rb'

module Talia
  module Net
    module Message

      class SMSG_DisplayMap < NetMessage
        attr_accessor :map

        def initialize(map)
          super('GDM')

          @map = map
        end

        def build()
          @buffer += "|#{@map.id}|#{@map.create_time}|#{@map.decrypt_key}"
        end
      end

    end
  end
end
