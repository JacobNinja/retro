module Retro
  module Handlers

    class PlaceStuff < Handler

      def call
        item_id, x, y = @data.split(" ")
        item = Item.new(id: 1, hand_type: "S", sprite: "test", width: 1, length: 1, col: 1.5)
        floor_furni = [1.to_s, 2.chr, "test", 2.chr, Encoding::VL64.encode(x.to_i), Encoding::VL64.encode(y.to_i), Encoding::VL64.encode(1), Encoding::VL64.encode(1), Encoding::VL64.encode(0), "0.00", 2.chr, "2", 2.chr, 2.chr, Encoding::VL64.encode(60), "furni_var", 2.chr].join
        ClientMessage.new("A]", floor_furni)
      end

    end

  end
end