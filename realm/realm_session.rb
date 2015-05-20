require './misc/logger.rb'
require './net/net_session.rb'

module Talia
  module Realm

    class RealmSession < NetSession
      def initialize(socket)
        super(socket)

      end
    end

  end
end
