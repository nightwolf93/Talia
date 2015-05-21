require './misc/logger.rb'
require './misc/io.rb'
require './misc/crypto.rb'
require './net/net_session.rb'
require './world/world_manager.rb'
require './db/models/account.rb'

Talia::Misc::IO.require_directory('./net/message')

module Talia
  module World

    class WorldSession < Net::NetSession
      def initialize(socket)
        super(socket)

      end
    end

  end
end
