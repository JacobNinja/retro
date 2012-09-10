module Retro
  module Handlers

    class RoomInfo < Handler

      def call
        room_id = data.rest.to_i
        Room.find_by_id(room_id) do |room|
          response = [
            Encoding::VL64.encode(0), # super users ?
            Encoding::VL64.encode(1), # room state
            Encoding::VL64.encode(room.id), # room id
            "-", # room owner
            2.chr,
            room.model + 2.chr,
            room.name + 2.chr,
            room.description + 2.chr,
            Encoding::VL64.encode(0), # show owner
            Encoding::VL64.encode(0), # can trade
            Encoding::VL64.encode(5), # user count
            Encoding::VL64.encode(25), # max users
          ]
          Client::Message.new("@v", response.join)
        end
      end

    end

  end
end