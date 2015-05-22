require './net/net_message.rb'

module Talia
  module Net
    module Message

      class SMSG_HelloGame < NetMessage
        attr_accessor :failure_type

        def initialize()
          super('HG')
        end

        def build()
          @buffer = ''
        end
      end

    end
  end
end
