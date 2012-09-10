module Retro
  module Handlers

    class CreateRoom < Handler

      def call
        _, _, room_name, room_model, room_status, show_owner = data.rest.split("/")
        RoomType.find_by_model(room_model) do |room_type|
          new_room = Room.create(room_name, user, room_type, room_status)
          return Client::Message.new("@{", new_room_response(new_room))
        end
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