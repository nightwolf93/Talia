require './misc/logger.rb'

module Talia
  module Misc

    class I18N

      @@i18n_file = nil

      def self.initialize(lang_id)
        @@i18n_file = Settings.new("./config/i18n_#{lang_id}.yml")
      end

      def self.get_text(text_id, data)
        text =  @@i18n_file.get_data()[text_id]

        return text
      end

    end

  end
end
