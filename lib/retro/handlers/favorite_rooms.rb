module Retro
  module Handlers

    class FavoriteRooms < Handler

      def call
        #guests = [private_room_response(nil)]
        #public = []
        #response = ["HHJ", 2.chr, "HHH", Encoding::VL64.encode(guests.count), guests.join].join
        response = ""
        ClientMessage.new("@}", response)
      end

      def private_room_response(hide_full)
        [].tap do |list|
          list << Encoding::VL64.encode(123) # room id
          list << "RoomName"
          list << 2.chr
          list << "-" # Room owner
          list << 2.chr
          list << "RoomStatus"
          list << 2.chr
          list << Encoding::VL64.encode(10) # current users
          list << Encoding::VL64.encode(25)
          list << "Room description"
          list << 2.chr
        end.join
      end

    end

  end
end