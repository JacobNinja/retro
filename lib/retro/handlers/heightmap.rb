module Retro
  module Handlers

    class Heightmap < Handler

      def call
        adjusted_heightmap = user.current_room.heightmap.gsub("|", "\r")
        Client::Message.new("@_", adjusted_heightmap)
      end

    end

  end
end