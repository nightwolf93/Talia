require 'rubygems'
require 'active_record'

module Talia
  module DB
    module Models

      class Account < ActiveRecord::Base
        attr_accessor :id, :username, :password, :nickname, :email, :scope_id
        self.table_name = "accounts"
        self.primary_key = "id"

        def self.find_by_username(username)
          return Account::where(username: username).first
        end
      end

    end
  end
end
