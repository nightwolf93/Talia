require './misc/logger.rb'
require './misc/io.rb'
require './net/net_session.rb'

Talia::Misc::IO.require_directory('./net/message')

module Talia
  module Realm

    module RealmState
      VERSION = 1
      AUTHENTIFICATION = 2
      SERVER_LIST = 3
    end

    class RealmSession < Net::NetSession
      attr_accessor :login_state

      def initialize(socket)
        super(socket)
        @login_state = RealmState::VERSION

        self.write_message(Net::Message::SMSG_RealmHelloKeyMessage.new("arandomkey"))
      end

      def on_data(data)

      end
    end

  end
end
