module Retro
  module Handlers

    class RoomDirectory < Handler

      def call
        request_type = data.pop_b64
        room_id = Encoding::VL64.decode(data.rest)
        response = ClientMessage.new("@S")
        if request_type == 1
          Room.find_by_id(room_id) do |room|
            [response, ClientMessage.new("Bf", "about:blank"), ClientMessage.new("AE", room.model)]
          end
        else
          response
        end
      end

    end

  end
end