require 'rubygems'
require 'active_record'

Talia::Misc::IO.require_directory('./net/message/world')
Talia::Misc::IO.require_directory('./world/engine')

module Talia
  module DB
    module Models

      class Map < ActiveRecord::Base
        after_initialize :setup
        self.table_name = "maps"
        self.primary_key = "id"

        def setup()
          @characters = Array.new
          @pathfinding = World::Engine::Pathfinding.new(self)
        end

        def self.find_all()
          return Map::all
        end

        def add_character(session, first = false)
          session.character.map_id = self.id

          self.dispatch_message(Net::Message::SMSG_DisplayMapCharacter.new([session]))
          @characters.push(session)
          session.write_message(Net::Message::SMSG_DisplayMap.new(self))
        end

        def display_characters(session)
          session.write_message(Net::Message::SMSG_DisplayMapCharacter.new(@characters))
        end

        def remove_character(session)
          @characters.delete(session)
          self.dispatch_packet("GM|-#{session.character.id}")
        end

        def dispatch_packet(packet)
          @characters.each do |character|
            character.write(packet)
          end
        end

        def dispatch_message(message)
          @characters.each do |character|
            character.write_message(message)
          end
        end
      end

    end
  end
end
