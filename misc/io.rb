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

    end

  end
end
