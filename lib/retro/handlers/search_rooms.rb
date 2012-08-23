module Retro
  module Handlers

    class SearchRooms < Handler

      def call
        # @y = no results
        flat = Flat.new(room_id: 123, name: "RoomName", owner: "somebody", max_guests: 25, description: "test")
        flat_response = [flat.room_id.to_s, flat.name, flat.owner, "open", "x", "0", flat.max_guests.to_s, "null", flat.description, "\r"]
        ClientMessage.new("@P", flat_response.join(9.chr))
      end

    end

  end
end