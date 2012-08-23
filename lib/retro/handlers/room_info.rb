module Retro
  module Handlers

    class RoomInfo < Handler

      def call
        room_id = data.to_i
        response = []
        response << Encoding::VL64.encode(0) # super users ?
        response << Encoding::VL64.encode(1) # room state
        response << Encoding::VL64.encode(room_id) # room id
        response << "-" # room owner
        response << 2.chr
        response << "model_a" + 2.chr
        response << "room name" + 2.chr
        response << "room description" + 2.chr
        response << Encoding::VL64.encode(0) # show owner
        response << Encoding::VL64.encode(0) # can trade
        response << Encoding::VL64.encode(5) # user count
        response << Encoding::VL64.encode(25) # max users
        ClientMessage.new("@v", response.join)
      end

    end

  end
end