module Retro
  module Handlers

    class TryFlat < Handler

      def call
        #room_id = data.to_i
        Client::Message.new("@i")
      end

    end
  end
end