require './net/net_message.rb'

module Talia
  module Net
    module Message

      class SMSG_RealmServerState < NetMessage
        attr_accessor :server_id, :state

        def initialize(id, state)
          super('AH')
          @server_id = id
          @state = state
          @server_id_mul = @server_id * 75
        end

        def build()
          @buffer = "#{@server_id};#{@state};#{@server_id_mul};1"
        end
      end

    end
  end
end
