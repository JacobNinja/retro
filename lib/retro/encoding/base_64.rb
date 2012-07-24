module Retro

  module Encoding

    class Base64

      def self.encode(len)
        (1..2).map do |idx|
          offset = 6 * (2 - idx)
          (64 + (len >> offset & 0x3f)).chr
        end.join
      end

      def self.decode(str)
        str.reverse.each_char.with_index.reduce(0) do |sum, (char, idx)|
          tmp = char.ord - 64
          sum + (idx > 0 ? tmp * (64 ** idx) : tmp)
        end
      end

    end

  end

end