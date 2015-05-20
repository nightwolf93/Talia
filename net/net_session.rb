module Talia
  module Net

    class NetSession
      attr_accessor :socket

      def initialize(socket)
          @socket = socket
      end
    end

  end
end
