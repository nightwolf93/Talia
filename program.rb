require './misc/settings.rb'
require './misc/logger.rb'

module Talia

  class Program
    def initialize()
      @settings = Misc::Settings.new()
    end
  end
  
end

program = Talia::Program.new()
