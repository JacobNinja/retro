module Retro
  module Handlers

    class GotoFlat < Handler

      def call
        #room_id = data.to_i
        [
            ClientMessage.new("Bf", "about:blank"),
            ClientMessage.new("AE", "model_a"),
            ClientMessage.new("@n", "wallpaper/0"),
            ClientMessage.new("@n", "floor/0"),
        ]
      end

    end

  end
end