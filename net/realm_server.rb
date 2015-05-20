require 'socket'
require './misc/logger.rb'
require './net/net_server.rb'
require './realm/realm_session.rb'

module Talia
  module Net

    class RealmServer < NetServer
      attr_accessor :sessions

      def initialize()
        super(Program::instance.settings.get_data()["realm"]["port"])
        @server = nil
        @sessions = Array.new
      end

      def start()

      end

      def on_connection(socket)
        session = RealmSession.new(socket)
        @session.push(session)
      end
    end

  end
end
