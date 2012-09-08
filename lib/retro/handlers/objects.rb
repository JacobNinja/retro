module Retro
  module Handlers

    class Objects < Handler

      def call
        floor_items = Item.floor_items_in_room(user.current_room.id)
        item_response = ClientMessage.new("@`", Encoding::VL64.encode(floor_items.count))
        floor_items.each do |item|
          item_response.add floor_furni_response(item)
        end
        [
            ClientMessage.new("@^", ""),
            item_response
        ]
      end

      def floor_furni_response(item)
        [
            item.id,
            2.chr,
            item.sprite,
            2.chr,
            Encoding::VL64.encode(item.x),
            Encoding::VL64.encode(item.y),
            Encoding::VL64.encode(item.width),
            Encoding::VL64.encode(item.length),
            Encoding::VL64.encode(item.rotation),
            "0.00",
            2.chr,
            item.col,
            2.chr, 2.chr,
            Encoding::VL64.encode(item.teleport_id),
            item.furni_var,
            2.chr
        ].join
      end

      def floor_object_response(item)
        response = [
            item.id,
            item.sprite,
            item.x,
            item.y,
            item.z,
            item.rotation,
        ].join(" ")
        response + 13.chr
      end

    end

  end
end