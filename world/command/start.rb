require './misc/i18n.rb'

module Talia
  module World
    module Command

      class Start < ChatCommand
        def initialize()
          @identifier = 'start'
          @description = session.server_message(Misc::I18N.get_text('START_COMMAND_DESCRIPTION'))
          @min_level = 0
        end

        def handle(session, parameters)
          settings = Program::instance.settings.get_data()
          session.character.teleport_to(session, settings["gameplay"]["start"]["map"], settings["gameplay"]["start"]["cell"])
        end
      end

    end
  end
end
