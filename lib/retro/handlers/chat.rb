module Retro
  module Handlers

    class Chat < Handler

      def call
        user_id = 0
        message = data.pop_b64!
        if message.start_with? ":client"
          _, header, *body = message.split(" ")
          return Client::Message.new(header, body.join(" "))
        elsif message.start_with? ":server"
          _, header, *body = message.split(" ")
          header_int = Encoding::B64.decode(header)
          handler = Handlers::SERVER_HEADERS[header_int]
          return handler.new(@session, body.join(" ")).call if handler
        end
        response = Encoding::VL64.encode(user_id) + message + 2.chr
        Client::Message.new("@X", response)
      end

    end

  end
end