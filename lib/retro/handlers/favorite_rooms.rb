module Retro
  module Handlers

    class FavoriteRooms < Handler

      def call
        guests = [private_room_response(nil)]
        #public = []
        response = ["HHJ", 2.chr, "HHH", Encoding::VL64.encode(guests.count), guests.join].join
        ClientMessage.new("@}", response)
      end

    end

  end
end