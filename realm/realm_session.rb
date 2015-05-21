require './misc/logger.rb'
require './misc/io.rb'
require './misc/crypto.rb'
require './net/net_session.rb'
require './world/world_manager.rb'
require './db/models/account.rb'

Talia::Misc::IO.require_directory('./net/message')

module Talia
  module Realm

    module RealmState
      WAIT = 0
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
        @key = Misc::Crypto.random_string(32)

        self.write_message(Net::Message::SMSG_RealmHelloKeyMessage.new(@key))
      end

      def on_data(data)
        begin
          case @login_state
          when RealmState::VERSION
            self.on_handle_version(Net::Message::CMSG_RealmClientVersion.new(data))
          when RealmState::AUTHENTIFICATION
            self.on_handle_authentification(Net::Message::CMSG_RealmAuthentificationRequest.new(data))
          when RealmState::SERVER_LIST
            self.on_handle_server_list(data)
          end
        rescue Exception => e
          puts e.message
        end
      end

      def on_close()
        Program::instance.realm_server.sessions.delete(self)
        @logger.log("Disconnected from realm server")
      end

      def on_handle_version(packet)
        version = Program::instance.settings.get_data()['security']['client_version']
        if packet.version == version
          @login_state = RealmState::AUTHENTIFICATION
        else
          self.write_message(Net::Message::SMSG_RealmAuthentificationFailure.new(AuthentificationFailureType::WRONG_VERSION, version))
          self.close()
        end
      end

      def on_handle_authentification(packet)
        @login_state = RealmState::WAIT
        account = DB::Models::Account.find_by_username(packet.username)
        if account != nil
          pass_crypted = Misc::Crypto.dofus_special_encryption(account.password, @key)
          if pass_crypted == packet.password
            @account = account
            @logger.log("Player authenficated on account '#{account.username}'")
            @login_state = RealmState::SERVER_LIST
            self.send_account_informations
          else
            self.write_message(Net::Message::SMSG_RealmAuthentificationFailure.new(AuthentificationFailureType::WRONG_CREDITENTIALS))
            self.close()
          end
        else
          self.write_message(Net::Message::SMSG_RealmAuthentificationFailure.new(AuthentificationFailureType::WRONG_CREDITENTIALS))
          self.close()
        end
      end

      def on_handle_server_list(data)
        if data[0..1] == 'Ax'
          self.write_message(Net::Message::SMSG_RealmCharactersList.new(10000, 1, 1))
        elsif data[0..1] == 'AX'
          config = Program::instance.settings.get_data()['world']
          packet = Net::Message::CMSG_RealmWorldSelection.new(data)
          ticket = Misc::Crypto.random_string(20)
          World::WorldManager.subscribe_ticket_player(ticket, @account)
          self.write_message(Net::Message::SMSG_RealmTicket.new(config['host'], config['port'], ticket))
        end
      end

      def send_account_informations()
        self.write_message(Net::Message::SMSG_RealmAccountNickname.new(@account.nickname))
        self.write("Ac0")
        self.send_server_state
        self.write_message(Net::Message::SMSG_RealmAccountRole.new(@account.scope_id.to_i > 0 ? 0 : 1))
      end

      def send_server_state()
        self.write_message(Net::Message::SMSG_RealmServerState.new(1, WorldStateType::ONLINE))
      end
    end

  end
end
