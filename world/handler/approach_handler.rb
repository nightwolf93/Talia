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
              session.close
            end
          end
        end

        def self.send_characters_list(session)
          #TODO
        end

        def self.handle_random_name()
          name = ''
          combo = ["ai", "az", "aw", "an", "as", "au", "al", "ba", "bi", "bo", "by", "bl", "ca", "co",
             "ci", "cy", "da", "de", "du", "di", "la", "lo", "li", "pa", "pi", "po", "ka", "ki", "ko",
             "va", "vo", "vi", "ya", "yo", "yi", "wa", "wi", "wo", "ha", "hi", "ho", "ma", "mi", "mo",
             "na", "ni", "no", "ja", "jo", 'ji', "sa", "so", "si", "fa", "fo", "fi", "xa", "xi", "xo",
             "ra", "ri", "ro", "ru", "ul", "ub", "un", "yu"]
          for $i in [0..Random.new.rand(2, 6)]
            pair = combo[Random.new.rand(0, combo.length - 1)]
            name += pair
          end
          @@logger.debug("generate random name : #{name}")
          return name
          #TODO: Send random name to player
        end
    end
  end
end
