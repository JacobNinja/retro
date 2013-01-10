module Retro
  module Handlers

    class RoomDirectory < Handler

      def call
        room_type = data.pop_b64
        room_id = Encoding::VL64.decode(data.rest)
        response = Client::Message.new("@S")
        room = RoomManager.find(room_id)
        return response unless room

        user_manager.enter(room, 0)
        [response, Client::Message.new("Bf", "about:blank"), Client::Message.new("AE", room.model)]
      end

    end

  end
end