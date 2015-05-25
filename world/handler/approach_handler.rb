require './misc/logger.rb'

Talia::Misc::IO.require_directory('./net/message/world')

module Talia
  module World
    module Handler

      class ApproachHandler
        @@logger = Misc::Logger.new(ApproachHandler)

        def self.handle_authentification_ticket(session, packet)
          account = WorldManager.get_account_by_ticket(packet.ticket)
          if account != nil
            session.account = account
            self.send_characters_list(session)
            @@logger.log("Player '#{account.username}' has switched on world successfuly")
          else
            @@logger.error("Can't found the account for the ticket : #{packet.ticket}")
            session.close
          end
        end

        def self.send_characters_list(session)
          session.characters = DB::Models::Character.find_by_account(session.account.id)
          session.write_message(Net::Message::SMSG_CharactersList.new(100000, session.characters))
        end

        def self.handle_random_name(session)
          name = ''
          combo = ["ai", "az", "aw", "an", "as", "au", "al", "ba", "bi", "bo", "by", "bl", "ca", "co",
             "ci", "cy", "da", "de", "du", "di", "la", "lo", "li", "pa", "pi", "po", "ka", "ki", "ko",
             "va", "vo", "vi", "ya", "yo", "yi", "wa", "wi", "wo", "ha", "hi", "ho", "ma", "mi", "mo",
             "na", "ni", "no", "ja", "jo", 'ji', "sa", "so", "si", "fa", "fo", "fi", "xa", "xi", "xo",
             "ra", "ri", "ro", "ru", "ul", "ub", "un", "yu"]
          for $i in 0..Random.new.rand(2..4)
            pair = combo[Random.new.rand(0..combo.length - 1)]
            name += pair
          end
          session.write_message(Net::Message::SMSG_RandomName.new(name))
        end

        def self.handle_create_character(session, packet)
          settings = Program::instance.settings.get_data()

          if !DB::Models::Character.exist_name(packet.name)
            character = DB::Models::Character.new()
            character.account_id = session.account.id
            character.nickname = packet.name
            character.level = 1
            character.experience = 0
            character.gender = packet.gender
            character.breed_id = packet.breed
            character.color_1 = packet.color_1
            character.color_2 = packet.color_1
            character.color_3 = packet.color_3
            character.kamas = settings["gameplay"]["start"]["kamas"]
            character.map_id = settings["gameplay"]["start"]["map"]
            character.cell_id = settings["gameplay"]["start"]["cell"]
            character.orientation_id = settings["gameplay"]["start"]["orientation"]

            character.save()
            self.send_characters_list(session)
          else
            session.write("AAEa")
          end
        end

        def self.handle_character_delete(session, packet)
          character = session.account.get_character(packet.id)
          character.destroy()
          ApproachHandler.send_characters_list(session)
        end

        def self.handle_character_selection(session, packet)
          character = session.account.get_character(packet.id)
          session.character = character
          session.write_message(Net::Message::SMSG_CharacterSelection.new(character))
        end

        def self.handle_game_context(session, packet)
          @@logger.log("Player selected the character '#{session.character.nickname}'")
        end
      end

    end
  end
end
