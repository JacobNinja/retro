module Retro
  module Handlers

    class Items < Handler

      def call
        wall_items = ""
        [
            ClientMessage.new("@m", wall_items)
        ]
      end

    end

  end
end