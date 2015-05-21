require './net/net_message.rb'

module Talia
  module Net
    module Message

      class SMSG_RealmCharactersList < NetMessage
        attr_accessor :server_id

        def initialize(subscription_remaining, server_id, character_count)
          super('AxK')
          @subscription_remaining = subscription_remaining
          @server_id = server_id
          @character_count = character_count
        end

        def build()
          @buffer = "#{@subscription_remaining}|#{@server_id},#{@character_count}"
        end
      end

    end
  end
end
