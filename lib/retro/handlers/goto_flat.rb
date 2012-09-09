module Retro
  module Handlers

    class GotoFlat < Handler

      def call
        room_id = data.rest.to_i
        Room.find_by_id(room_id) do |room|
          user.current_room = room
          user.current_room_id = 0 # Generate this
          user.states.add_rights if room.owned_by?(user)
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