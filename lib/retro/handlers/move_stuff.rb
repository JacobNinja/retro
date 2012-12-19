module Retro
  module Handlers

    class MoveStuff < Handler

      def call
        id, x, y, rotation = data.rest.split(" ").map(&:to_i)
        item = RoomManager.new(user.current_room).move(id.to_i, x, y, rotation)
        return nil unless item

        [
          Client::Message.new("A_", floor_response(item)),
          Client::MessageFactory.heightmap(user.current_room),
        ]
      end

      def floor_response(item)
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
          item.z,
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