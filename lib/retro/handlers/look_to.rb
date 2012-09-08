module Retro
  module Handlers

    class LookTo < Handler

      def call
        body_movement, head_movement = data.rest.split(" ")
        user.body_direction = body_movement
        user.head_direction = head_movement
        Client::MessageFactory.room_movement(user)
      end

    end

  end
end