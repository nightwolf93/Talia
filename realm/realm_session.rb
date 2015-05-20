require './misc/logger.rb'
require './net/net_session.rb'

module Talia
  module Realm

    class RealmSession < Net::NetSession
      def initialize(socket)
        super(socket)
        self.write 'HCverjizehzeihcuhzeshc'
      end

      def on_data(data)

      end
    end

  end
end
