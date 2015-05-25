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

        def get_characters()
          return DB::Models::Character.find_by_account(self.id)
        end

        def get_character(id)
          for $c in self.get_characters()
            if $c.id == id.to_i
              return $c
            end
          end
          return nil
        end

        def has_reached_max_character()
          count = self.get_characters().length
          if count >= 5
            return true
          else
            return false
          end
        end
      end

    end
  end
end
