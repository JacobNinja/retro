module Retro
  module Handlers

    class Stop < Handler

      def call
        if data.rest == "Dance"
          user.states.dance!
          Client::MessageFactory.room_movement(user)
        end
      end

    end

  end
end