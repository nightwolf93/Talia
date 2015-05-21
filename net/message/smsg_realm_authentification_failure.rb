require './net/net_message.rb'

module Talia
  module Net
    module Message

      class SMSG_RealmAuthentificationFailure < NetMessage
        attr_accessor :failure_type

        def initialize(failure_type)
          super('AlE')
          @failure_type = failure_type
        end

        def build()
          @buffer = @failure_type
        end
      end

    end
  end
end
