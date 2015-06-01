require './misc/logger.rb'

Talia::Misc::IO.require_directory('./db/models')

module Talia
  module World

    class WorldManager
      @@logger = Misc::Logger.new(WorldManager)
      @@tickets = Hash.new
      @@maps = Array.new

      def self.subscribe_ticket_player(ticket, account)
        @@tickets[ticket] = account
        @@logger.log("Subscribe new world account with ticket : #{ticket}")
      end

      def self.get_account_by_ticket(ticket)
        return @@tickets[ticket]
      end

      def disconnect_player_on_account(account)
        Program::instance.realm_server.sessions.each do |session|
          if session.account != nil
            if session.account.id == account.id
              session.close()
              return
            end
          end
        end
        Program::instance.world_server.sessions.each do |session|
          if session.account != nil
            if session.account.id == account.id
              session.close()
              return
            end
          end
        end
      end

      def self.load_world()
        WorldManager.load_maps()
        @@logger.log("World loaded")
      end

      def self.load_maps()
        @@logger.log("Loading maps ..")
        @@maps = DB::Models::Map.find_all()
        @@logger.log("#{@@maps.count} maps loaded")
      end

      def self.get_map(id)
        @@maps.each do |map|
          if map.id == id
            return map
          end
        end
        return nil
      end
    end

  end
end
