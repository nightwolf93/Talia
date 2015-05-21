require 'digest/md5'

require './misc/logger.rb'

module Talia
  module Misc

    class Crypto
      @@hash = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i',
                'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's',
                't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C',
                'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
                'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U',
                'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4',
                '5', '6', '7', '8', '9', '-', '_']

      def self.dofus_special_encryption(password, key)
        crypted = ''

        for $i in 0..password.length
          ppas = password[$i]
          ppkey = key[$i]
          apass = (ppas / 16).to_i
          akey = (ppas % 16).to_i
          anb = (apass + (pkey).to_i) % @@hash.length
          anb2 = (akey + (pkey).to_i) % @@hash.length

          crypted += @@hash[anb]
          crypted += @@hash[anb2]
        end
        return crypted
      end

      def self.random_string(length=32)
        string = ''
        for $i in 0..length
          string += @@hash[Random.new.rand(0..@@hash.length-1)]
        end
        return string
      end
    end

  end
end
