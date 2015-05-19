#!/usr/bin/env ruby

require './misc/settings.rb'
require './misc/logger.rb'
require './net/realm_server.rb'

module Talia

  class Program
    def initialize()
      @logger = Misc::Logger.new(self.class)
      @logger.log "Initializing Talia .."
      @settings = Misc::Settings.new('./config/app.yml')

      self.initialize_network()

      while true
        command = gets.chomp
      end
    end

    def initialize_network()
      @logger.log "Starting network services .."

      @auth_server = Net::RealmServer.new()
      @auth_server.start()

    end
  end

end

program = Talia::Program.new()
