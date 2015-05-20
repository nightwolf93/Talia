require 'rubygems'
require 'active_record'

module Talia
  module DB
    module Models

      class WorldServer < ActiveRecord::Base
        attr_accessor :id, :name, :host, :game_port, :private_port
        self.table_name = "world_servers"
        self.primary_key = "id"

        def self.find_all()
          return WorldServer::find(:all, :order => "attending DESC")
        end
      end

    end
  end
end
