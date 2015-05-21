module Talia
  module Misc

    class IO

      def self.get_file_content(file)
        data = ''
        f = File.open(file, "r")
        f.each_line do |line|
          data += line
        end
        return data
      end

      def self.require_directory(directory)
        Dir["#{directory}/*.rb"].each {|file| require file }
      end

    end

  end
end
