require './misc/logger.rb'
require './misc/i18n.rb'

Talia::Misc::IO.require_directory('./net/message/world')

module Talia
  module World
    module Handler

      class GameHandler
        def self.handle_game_context(session, packet)
          case packet.id
          when 1
            if session.state == World::WorldSessionState::CHARACTER_SELECTION
              session.write("GCK|1|" + session.character.nickname);
              session.write('cC+*#$pi:?%');
              session.write("AR6bk");
              session.state == World::WorldSessionState::IN_GAME

              session.server_message(Misc::I18N.get_text('WELCOME_MESSAGE'))

              session.character.get_map().add_character(session, true)
            end
          end
        end

        def self.handle_game_informations_request(session)
          session.character.get_map().display_characters(session)
          session.write("GDK")
        end
      end

    end
  end
end
