module Retro
  module Handlers

    class Dance < Handler

      def call
        user.states.dance
        Client::MessageFactory.room_movement(user)
      end

    end

  end
end