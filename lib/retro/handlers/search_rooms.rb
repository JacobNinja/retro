module Retro
  module Handlers

    class SearchRooms < Handler

      def call
        # @y = no results
        room_response = user.rooms.map &method(:search_response)
        Client::Message.new("@P", room_response.join)
      end

      def search_response(room)
        [
            room.id,
            room.name,
            "-",
            "open",
            "x",
            "0", # current users
            25, # max guests
            "null",
            room.description,
            room.description,
            13.chr
        ].join(9.chr)
      end

    end

  end
end