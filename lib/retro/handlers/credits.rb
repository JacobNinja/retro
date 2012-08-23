module Retro
  module Handlers

    class Credits < Handler

      def call
        ClientMessage.new(:credits, "0.0")
      end

    end

  end
end