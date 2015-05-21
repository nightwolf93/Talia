require 'rubygems'
require 'active_record'

module Talia
  module DB
    module Models

      class Account < ActiveRecord::Base
        self.table_name = "accounts"
        self.primary_key = "id"

        def self.find_by_username(username)
          return Account::where(username: username).first
        end
      end

    end
  end
end
