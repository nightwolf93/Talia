require './net/net_message.rb'

module Talia
  module Net
    module Message

      class SMSG_RealmHelloKeyMessage < NetMessage
        attr_accessor :encrypt_key

        def initialize(encrypt_key)
          super('HC')
          @encrypt_key = encrypt_key
        end

        def build()
          @buffer = @encrypt_key
        end
      end

    end
  end
end
