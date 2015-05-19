require './misc/settings.rb'
require './misc/logger.rb'
require './net/auth_server.rb'

module Talia

  class Program
    def initialize()
      @logger = Misc::Logger.new(self.class)
      @logger.log "Initializing Talia .."
      @settings = Misc::Settings.new('./config/app.yml')

      self.initialize_network()
    end

    def initialize_network()
      @logger.log "Starting network services .."
    end
  end

end

program = Talia::Program.new()
