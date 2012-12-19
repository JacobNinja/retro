module Retro
  module Handlers

    class HotelView < Handler

      def call
        room_id = user.current_room_id
        UserManager.new(user).leave
        Client::Message.new("@]", room_id)
      end

    end

  end
end