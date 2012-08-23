module Retro
  module Handlers

    class TryFlat < Handler

      def call
        #room_id = data.to_i
        ClientMessage.new("@i")
      end

    end
  end
end