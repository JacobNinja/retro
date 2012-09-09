module Retro
  module Handlers

    class Credits < Handler

      def call
        Client::Message.new(:credits, "0.0")
      end

    end

  end
end