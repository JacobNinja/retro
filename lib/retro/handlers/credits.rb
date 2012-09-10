module Retro
  module Handlers

    class Credits < Handler

      def call
        Client::Message.new(:credits, "100.0")
      end

    end

  end
end