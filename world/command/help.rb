require './misc/i18n.rb'

module Talia
  module World
    module Command

      class Help < ChatCommand
        def initialize()
          @identifier = 'help'
          @description = session.server_message(Misc::I18N.get_text('HELP_COMMAND_DESCRIPTION'))
          @min_level = 0
        end

        def handle(session, parameters)
          help = Misc::I18N.get_text('HELP_COMMAND_HEADER') + "<br />"
          World::WorldManager.commands.each do |command|
            help += "<b>#{command.identifier}</b> : #{command.description}<br />"
          end
          session.server_message(help)
        end
      end

    end
  end
end
