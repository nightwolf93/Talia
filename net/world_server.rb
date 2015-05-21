require 'socket'
require './misc/logger.rb'
require './net/net_server.rb'
require './world/world_session.rb'

module Talia
  module Net

    class WorldServer < NetServer
      attr_accessor :sessions

      def initialize()
        super(Program::instance.settings.get_data()["world"]["host"],
         Program::instance.settings.get_data()["world"]["port"])
        @server = nil
        @sessions = Array.new
      end

      def on_connection(socket)
        session = World::WorldSession.new(socket)
        @session.push(session)
      end
    end

  end
end
