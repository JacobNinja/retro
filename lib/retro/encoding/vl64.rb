module Retro
  module Encoding
    class VL64

      def self.encode(int)
        negative_mask = (int >= 0) ? 0 : 4
        result = [64 + (int & 3)]
        i = int.abs >> 2
        until i.zero? do
          result.push (64 + (i & 0x3f))
          i >>= 6
        end
        result[0] = (result[0] + (result.length << 3) + negative_mask)
        result.compact.map(&:chr).join
      end

      def self.decode(str)
        bytes = str.each_byte
        negative = (bytes.first & 4) == 4
        result = bytes.first & 3
        bytes.drop(1).each_with_index.inject(2) do |shift_amount, (byte, idx)|
          result |= ((byte & 0x3f) << shift_amount)
          2 + 6 * idx.next
        end
        negative ? result.abs : result
      end

    end
  end
end