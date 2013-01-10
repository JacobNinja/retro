module Retro
  module Handlers

    class GotoFlat < Handler

      def call
        room_id = data.rest.to_i
        room = RoomManager.find(room_id)
        return nil unless room

        user_manager.enter(room, 0)
        [
            Client::Message.new("Bf", "about:blank"),
            Client::Message.new("AE", room.model),
            Client::Message.new("@n", "wallpaper/#{room.wallpaper}"),
            Client::Message.new("@n", "floor/#{room.floor}"),
        ]
      end

    end

  end
end