module Talia
  module Misc

    class System
      def self.get_os()
        if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
          return 'WINDOWS'
        elsif (/darwin/ =~ RUBY_PLATFORM) != nil
          return 'MAC OS'
        elsif (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) == nil
          return 'LINUX'
        end
      end
    end

  end
end
