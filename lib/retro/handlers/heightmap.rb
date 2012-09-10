module Retro
  module Handlers

    class Heightmap < Handler

      def call
        Client::MessageFactory.heightmap(user.current_room)
      end

    end

  end
end