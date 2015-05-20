#!/usr/bin/env ruby

require 'dl'
require './misc/settings.rb'
require './misc/logger.rb'
require './net/realm_server.rb'
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
      @logger.log "Initializing Talia .."
      @settings = Misc::Settings.new('./config/app.yml')

      self.initialize_data()
      self.initialize_network()

      while true
        command = gets.chomp
      end
    end

    def initialize_data()
      @logger.log "Initializing database connection .."
      DB::Database.initialize()
    end

    def initialize_network()
      @logger.log "Starting network services .."

      @realm_server = Net::RealmServer.new()
      @realm_server.start()

      @logger.log "RealmServer started"
    end
  end

end

program = Talia::Program.new()
