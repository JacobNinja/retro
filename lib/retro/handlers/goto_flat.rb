module Retro
  module Handlers

    class GotoFlat < Handler

      def call
        room_id = data.rest.to_i
        Room.find_by_id(room_id) do |room|
          [
              ClientMessage.new("Bf", "about:blank"),
              ClientMessage.new("AE", room.model),
              ClientMessage.new("@n", "wallpaper/0"),
              ClientMessage.new("@n", "floor/0"),
          ]
        end
      end

    end

  end
end