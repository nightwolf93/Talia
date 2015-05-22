require 'rubygems'
require 'active_record'

module Talia
  module DB
    module Models

      class Character < ActiveRecord::Base
        self.table_name = "characters"
        self.primary_key = "id"

        def self.find_by_account(account_id)
          return Character::where(account_id: account_id)
        end
      end

    end
  end
end
