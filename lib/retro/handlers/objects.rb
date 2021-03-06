module Retro
  module Handlers

    class Objects < Handler

      def call
        floor_items = ItemManager.in_room(user.current_room)
        item_response = Client::Message.new("@`", Encoding::VL64.encode(floor_items.count))
        floor_items.each do |item|
          item_response.add floor_furni_response(item)
        end
        [
            Client::Message.new("@^", ""),
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
            item.z || 0,
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
            item.z || 0,
            item.rotation,
        ].join(" ")
        response + 13.chr
      end

    end

  end
end