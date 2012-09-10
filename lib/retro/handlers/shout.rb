module Retro
  module Handlers

    class Shout < Handler

      def call
        message = data.pop_b64!
        response = Encoding::VL64.encode(user.current_room_id) + message + 2.chr
        Client::Message.new("@Z", response)
      end

    end
  end
end