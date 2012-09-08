module Retro
  module Handlers

    class PlaceStuff < Handler

      def call
        item_id, x, y = data.rest.split(" ")
        Item.find_by_id(item_id) do |item|
          header = item.in_room? ? "A_" : "A]"
          if item.wall_item?
            # ummm...
          else
            ClientMessage.new(header, floor_response(item, x, y))
          end
        end
      end

      def floor_response(item, x, y, z=0)
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
          z,
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