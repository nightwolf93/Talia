require './misc/i18n.rb'

module Talia
  module World
    module Command

      class ChatCommand
        attr_accessor :identifier, :description, :min_level

        def handle(session, parameters)
          raise "Method need to be implemented"
        end

        def insufficient_permission(session)
          session.server_message(Misc::I18N.get_text('ROLE_PERMISSION_REQUIRED'))
        end

        def has_permission(session)
          if session.account != nil
            if session.account.scope_id
              return true
            else
              self.insufficient_permission
              return false
            end
          else
            self.insufficient_permission
            return false
          end
        end
      end

    end
  end
end
