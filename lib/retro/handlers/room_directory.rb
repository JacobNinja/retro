module Retro
  module Handlers

    class RoomDirectory < Handler

      def call
        request_type = data.pop_b64
        room_id = Encoding::VL64.decode(data.rest)
        response = Client::Message.new("@S")
        room = RoomManager.find(room_id)
        return response unless room

        if request_type == 1
          [response, Client::Message.new("Bf", "about:blank"), Client::Message.new("AE", room.model)]
        else
          response
        end
      end

    end

  end
end