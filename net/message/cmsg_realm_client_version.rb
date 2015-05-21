require './net/net_message.rb'

module Talia
  module Net
    module Message

      class CMSG_RealmClientVersion < NetMessage
        attr_accessor :version

        def initialize(version)
          super()
          @version = version
        end
      end

    end
  end
end
