module Retro
  module Handlers

    class RoomDirectory < Handler

      def call
        request_type = Encoding::Base64.decode(data[0..1])
        room_id = Encoding::VL64.decode(data[2..-1])
        ClientMessage.new("@S")
      end

    end

  end
end