require './misc/logger.rb'
require './misc/io.rb'
require './misc/crypto.rb'
require './net/net_session.rb'

Talia::Misc::IO.require_directory('./net/message')

module Talia
  module Realm

    module RealmState
      VERSION = 1
      AUTHENTIFICATION = 2
      SERVER_LIST = 3
    end

    module AuthentificationFailureType
      WRONG_VERSION = 'v'
      WRONG_CREDITENTIALS = 'x'
    end

    module WorldStateType
      OFFLINE = 0
      ONLINE = 1
    end

    class RealmSession < Net::NetSession
      attr_accessor :login_state, :account

      def initialize(socket)
        super(socket)
        @login_state = RealmState::VERSION

        self.write_message(Net::Message::SMSG_RealmHelloKeyMessage.new(Misc::Crypto.random_string(32)))
      end

      def on_data(data)
        case @login_state
        when RealmState::VERSION
          self.on_handle_version(Net::Message::CMSG_RealmClientVersion.new(data))
        when RealmState::AUTHENTIFICATION
          self.on_handle_authentification(Net::Message::CMSG_RealmAuthentificationRequest.new(data))
        when RealmState::SERVER_LIST
          self.on_handle_server_list()
        end
      end

      def on_handle_version(packet)
        if packet.version == Program::instance.settings.get_data()['security']['client_version']
          @login_state = RealmState::AUTHENTIFICATION
        else
          self.write_message(Net::Message::SMSG_RealmAuthentificationFailure.new(AuthentificationFailureType::WRONG_VERSION))
          self.close()
        end
      end

      def on_handle_authentification(packet)

      end

      def on_handle_server_list()

      end

      def send_account_informations()
        self.write_message(Net::Message::SMSG_RealmAccountNickname.new(@account["nickname"]))
        self.write("Ac0")
        self.send_server_state
        self.write_message(Net::Message::SMSG_RealmAccountRole.new(@account["scope_id"] > 0 ? 0 : 1))
      end

      def send_server_state()
        self.write_message(Net::Message::SMSG_RealmServerState.new(1, WorldStateType::ONLINE))
      end
    end

  end
end
