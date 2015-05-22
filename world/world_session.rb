require './misc/logger.rb'
require './misc/io.rb'
require './misc/crypto.rb'
require './net/net_session.rb'
require './world/world_manager.rb'
require './db/models/account.rb'

Talia::Misc::IO.require_directory('./net/message/world')
Talia::Misc::IO.require_directory('./world/handler')

module Talia
  module World

    class WorldSession < Net::NetSession
      attr_accessor :account, :characters

      def initialize(socket)
        super(socket)

        self.write_message(Net::Message::SMSG_HelloGame.new)
      end

      def on_data(data)
        case data[0]
        when 'A'
          case data[1]
          when 'T'
            Handler::ApproachHandler.handle_authentification_ticket(Net::Message::CMSG_AuthentificationTicket.new(data))
          end
        end
      end

      def on_close()

      end
    end

  end
end
