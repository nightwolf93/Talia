require './net/net_message.rb'

module Talia
  module Net
    module Message

      class SMSG_RandomName < NetMessage
        attr_accessor :name

        def initialize(name)
          super('APK')
          @name = name
        end

        def build()
          @buffer = @name
        end
      end

    end
  end
end
