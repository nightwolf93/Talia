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

    module WorldSessionState
      CHARACTER_SELECTION = 1
      IN_GAME = 2
    end

    class WorldSession < Net::NetSession
      attr_accessor :account, :characters, :character, :state

      def initialize(socket)
        super(socket)

        @character = nil
        @state = WorldSessionState::CHARACTER_SELECTION
        self.write_message(Net::Message::SMSG_HelloGame.new)
      end

      def on_data(data)
        begin
          case data[0]
          when 'A'
            case data[1]
            when 'A'
              Handler::ApproachHandler.handle_create_character(self, Net::Message::CMSG_CreateCharacter.new(data))
            when 'D'
              Handler::ApproachHandler.handle_character_delete(self, Net::Message::CMSG_CharacterDeletion.new(data))
            when 'T'
              Handler::ApproachHandler.handle_authentification_ticket(self, Net::Message::CMSG_AuthentificationTicket.new(data))
            when 'P'
              Handler::ApproachHandler.handle_random_name(self)
            when 'S'
              Handler::ApproachHandler.handle_character_selection(self, Net::Message::CMSG_CharacterSelection.new(data))
            end
          when 'B'
            case data[1]
            when 'M'
              Handler::GameHandler.handle_chat_message(self, Net::Message::CMSG_ChatClientMessage.new(data))
            end
          when 'G'
            case data[1]
            when 'C'
              Handler::GameHandler.handle_game_context(self, Net::Message::CMSG_GameContextRequest.new(data))
            when 'I'
              Handler::GameHandler.handle_game_informations_request(self)
            end
          end
        rescue Exception => e
          puts "Error : " + e.message
          puts e.backtrace
        end
      end

      def on_close()
        @character.remove_from_world(self)
      end

      def server_message(message)
        self.write('cs<font color="#CC0000">' + message + '</font>')
      end
    end

  end
end
