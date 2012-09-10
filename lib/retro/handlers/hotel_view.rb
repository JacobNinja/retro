module Retro
  module Handlers

    class HotelView < Handler

      def call
        room_id = user.current_room_id
        user.leave_room
        Client::Message.new("@]", room_id)
      end

    end

  end
end