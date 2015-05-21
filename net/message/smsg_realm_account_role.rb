require './net/net_message.rb'

module Talia
  module Net
    module Message

      class SMSG_RealmAccountRole < NetMessage
        attr_accessor :role_id

        def initialize(role_id)
          super('AlK')
          @role_id = role_id.to_s
        end

        def build()
          @buffer = @role_id
        end
      end

    end
  end
end
