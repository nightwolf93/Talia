require './misc/logger.rb'

module Talia
  module World
    module Handler

      class ApproachHandler
        @@logger = Misc::Logger.new(ApproachHandler)

        def self.handle_authentification_ticket(session, packet)
          account = WorldManager.get_account_by_ticket(packet.ticket)
          if account != nil
            session.account = account
            session.characters = DB::Models::Character.find_by_account(account.id)
            self.send_characters_list(session)
            @@logger.log("Player '#{account.username}' has switched on world successfuly")
          else
            @@logger.error("Can't found the account for the ticket : #{packet.ticket}")
          end
        end
      end

      def self.send_characters_list(session)

      end
    end
  end
end
