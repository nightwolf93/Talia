require './misc/logger.rb'

module Talia
  module World

    class WorldManager
      @@logger = Misc::Logger.new(WorldManager)
      @@tickets = Hash.new

      def self.subscribe_ticket_player(ticket, account)
        @@tickets[ticket] = account
        @@logger.log("Subscribe new world account with ticket : #{ticket}")
      end
    end

  end
end
