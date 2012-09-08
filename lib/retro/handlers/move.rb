module Retro
  module Handlers

    class Move < Handler

      def call
        x = data.pop_b64
        y = data.pop_b64
        user.x = x
        user.y = y
        Client::MessageFactory.room_movement(user)
      end

    end

  end
end