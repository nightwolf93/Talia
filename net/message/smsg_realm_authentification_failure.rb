require './net/net_message.rb'

module Talia
  module Net
    module Message

      class SMSG_RealmAuthentificationFailure < NetMessage
        attr_accessor :failure_type

        def initialize(failure_type, data = '')
          super('AlE')
          @failure_type = failure_type
          @data = data
        end

        def build()
          @buffer = @failure_type + @data
        end
      end

    end
  end
end
