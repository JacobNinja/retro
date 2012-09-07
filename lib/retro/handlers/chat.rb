module Retro
  module Handlers

    class Chat < Handler

      def call
        message_length = Encoding::B64.decode(data[0..1])
        user_id = 0
        message = data.slice(2, message_length)
        if message.start_with? ":client"
          _, header, *body = message.split(" ")
          ClientMessage.new(header, body.join(" "))
        else
          response = Encoding::VL64.encode(user_id) + message + 2.chr
          ClientMessage.new("@X", response)
        end

      end

    end

  end
end