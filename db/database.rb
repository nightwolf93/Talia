require 'rubygems'
require 'active_record'
require 'mysql2'

require './misc/logger.rb'
require './db/models/account.rb'

module Talia
  module DB

    class Database
      def self.initialize()
        logger = Misc::Logger.new(Database)
        config = Program::instance.settings.get_data()

        ActiveRecord::Base.establish_connection(
          adapter:  'mysql2',
          database: config['database']['name'],
          username: config['database']['username'],
          password: config['database']['password'],
          host:     config['database']['host']
        )

        logger.log "Database connection initialized"
      end
    end

  end
end
