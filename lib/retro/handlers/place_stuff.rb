module Retro
  module Handlers

    class PlaceStuff < Handler

      def call
        item_id, x, y = data.rest.split(" ")
        item = Item.new(id: 1, hand_type: "S", sprite: "test", width: 1, length: 1, col: 1.5, rotation: 0, height: "0.00", teleport_id: 0, furni_var: "furni_var")
        ClientMessage.new("A]", floor_response(item, x, y))
      end

      def floor_response(item, x, y)
        [
          item.id,
          2.chr,
          item.sprite,
          2.chr,
          Encoding::VL64.encode(x.to_i),
          Encoding::VL64.encode(y.to_i),
          Encoding::VL64.encode(item.width),
          Encoding::VL64.encode(item.length),
          Encoding::VL64.encode(item.rotation),
          item.height,
          2.chr,
          item.col,
          2.chr,
          2.chr,
          Encoding::VL64.encode(item.teleport_id),
          item.furni_var,
          2.chr
        ].join
      end

    end

  end
end