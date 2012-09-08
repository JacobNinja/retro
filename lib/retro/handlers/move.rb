module Retro
  module Handlers

    class Move < Handler

      def call
        x = data.pop_b64
        y = data.pop_b64
        ClientMessage.new("@b", "0 #{x},#{y},0.0,2,2/\r")
      end

    end

  end
end