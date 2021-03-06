module Talia
  module Net
    module Message

      class NetMessage
        attr_accessor :identifier, :buffer

        def initialize(identifier = '', buffer = '')
          @identifier = identifier
          @buffer = buffer
        end

        def build()
          raise "Method need to be implemented"
        end

        def get_data()
          self.build
          @identifier + @buffer
        end
      end

    end
  end
end
