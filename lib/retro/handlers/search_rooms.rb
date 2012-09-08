module Retro
  module Handlers

    class SearchRooms < Handler

      def call
        # @y = no results
        flat_response = user.rooms.map &method(:search_response)
        ClientMessage.new("@P", flat_response.join(9.chr))
      end

      def search_response(room)
        [
            room.id.to_s,
            room.name,
            room.owner,
            "open",
            "x",
            "0",
            room.max_guests.to_s,
            "null",
            room.description,
            "\r"
        ]
      end

    end

  end
end