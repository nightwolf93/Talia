#!/usr/bin/env ruby

require 'dl'

require './misc/settings.rb'
require './misc/logger.rb'
require './misc/system.rb'
require './misc/crypto.rb'
require './misc/i18n.rb'
require './net/realm_server.rb'
require './net/world_server.rb'
require './db/database.rb'

module Talia

  class Program
    attr_accessor :settings, :realm_server
    @@instance = nil

    def self.instance
      @@instance
    end

    def initialize()
      @@instance = self
      @logger = Misc::Logger.new(self.class)
      @logger.log "Initializing Talia (running on #{Misc::System.get_os}) .."
      @settings = Misc::Settings.new('./config/app.yml')
      Misc::I18N.initialize(@settings.get_data()['talia']['lang'])

      self.initialize_data
      self.initialize_network

      while true
        begin
          command = gets.chomp
        rescue Exception => e
          @logger.error("Talia shutdown ..")
          break
        end
      end
    end

    def initialize_data()
      @logger.log "Initializing database connection .."
      DB::Database.initialize
    end

    def initialize_network()
      @logger.log "Starting network services .."

      @realm_server = Net::RealmServer.new
      @realm_server.start
      @logger.log "RealmServer started"

      @world_server = Net::WorldServer.new
      @world_server.start
      @logger.log "WorldServer started"
    end
  end

end

program = Talia::Program.new
