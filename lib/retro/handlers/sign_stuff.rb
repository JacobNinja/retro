module Retro
  module Handlers

    class SignStuff < Handler

      def call
        item_id = data.pop_b64!
        sign_data = data.pop_b64!
        item = ItemManager.find(item_id)
        return nil unless item

        ItemManager.sign(item.id, sign_data)
        [
            Client::Message.new("AX", sign_item_response(item, sign_data)),
            Client::MessageFactory.heightmap(user.current_room)
        ]
      end

      def sign_item_response(item, sign_data)
        [
            item.id,
            2.chr,
            sign_data,
            2.chr
        ].join
      end

    end

  end
end