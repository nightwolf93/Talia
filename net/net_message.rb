module Talia
  module Net
    module Message

      class NetMessage
        attr_accessor :identifier, :buffer

        def initialize(identifiern buffer = '')
          @identifier = identifier
          @buffer = buffer
        end

        def build()
          raise "Method need to be implemented"
        end

        def get_data()
          @identifier + @buffer
        end
      end

    end
  end
end
