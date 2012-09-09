module Retro
  module Handlers

    class Items < Handler

      def call
        wall_items = ""
        [
            Client::Message.new("@m", wall_items)
        ]
      end

    end

  end
end