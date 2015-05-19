require 'yaml'
require './misc/io.rb'
require './misc/logger.rb'

module Talia
  module Misc

    class Settings
      def initialize(name)
        @logger = Logger.new(self.class)
        @name = name
        @data = []
        self.load()
      end

      def load()
        file_content = IO.get_file_content(@name)
        @data = YAML.load(file_content)
        @logger.log("Settings loaded")
      end

      def get_data()
        return @data
      end
    end

  end
end
