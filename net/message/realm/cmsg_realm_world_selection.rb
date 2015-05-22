require './net/net_message.rb'

module Talia
  module Net
    module Message

      class CMSG_RealmWorldSelection < NetMessage
        attr_accessor :server_id

        def initialize(server_id)
          super()
          @server_id = server_id[2..3]
        end
      end

    end
  end
end
