require 'rubygems'
require 'active_record'

require './world/world_manager.rb'

module Talia
  module DB
    module Models

      class Character < ActiveRecord::Base
        self.table_name = "characters"
        self.primary_key = "id"

        def self.find_by_account(account_id)
          return Character::where(account_id: account_id)
        end

        def self.find_by_id(id)
          return Character::find(id)
        end

        def self.exist_name(name)
          return Character::where(nickname: name).length > 0
        end

        def get_default_look()
          return "#{self.breed_id.to_s}#{self.gender.to_s}"
        end

        def get_map()
          return World::WorldManager.get_map(self.map_id)
        end
      end

    end
  end
end
