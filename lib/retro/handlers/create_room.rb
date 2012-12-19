module Retro
  module Handlers

    class CreateRoom < Handler

      def call
        _, _, room_name, room_model, room_status, show_owner = data.rest.split("/")
        room_type = RoomTypeManager.find_by_model(room_model)
        return nil unless room_type

        new_room = RoomManager.create(room_name, user.id, room_type, room_status)
        Client::Message.new("@{", new_room_response(new_room))
      end

      def new_room_response(room)
        [
            room.id,
            13.chr,
            room.name
        ].join
      end

    end

  end
end