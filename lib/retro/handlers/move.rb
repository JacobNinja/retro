module Retro
  module Handlers

    class Move < Handler

      def call
        x = Encoding::Base64.decode(@data[0..1])
        y = Encoding::Base64.decode(@data[2..-1])
        ClientMessage.new("@b", "0 #{x},#{y},0.0,2,2/\r")
      end

    end

  end
end