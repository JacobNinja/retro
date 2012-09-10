module Retro
  module Handlers

    class GotoFlat < Handler

      def call
        room_id = data.rest.to_i
        Room.find_by_id(room_id) do |room|
          user.enter_room(room, 0)
          [
              Client::Message.new("Bf", "about:blank"),
              Client::Message.new("AE", room.model),
              Client::Message.new("@n", "wallpaper/0"),
              Client::Message.new("@n", "floor/0"),
          ]
        end
      end

    end

  end
end