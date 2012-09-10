module Retro
  module Handlers

    class MoveStuff < Handler

      def call
        id, x, y, rotation = data.rest.split(" ")
        Item.find_by_id(id) do |item|
          item.set_position(user.current_room.id, x, y, rotation)
          [
              Client::Message.new("A_", floor_response(item, x, y, rotation)),
              Client::MessageFactory.heightmap(user.current_room),
          ]
        end
      end

      def floor_response(item, x, y, rotation, z=0)
        [
          item.id,
          2.chr,
          item.sprite,
          2.chr,
          Encoding::VL64.encode(x.to_i),
          Encoding::VL64.encode(y.to_i),
          Encoding::VL64.encode(item.width),
          Encoding::VL64.encode(item.length),
          Encoding::VL64.encode(rotation.to_i),
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