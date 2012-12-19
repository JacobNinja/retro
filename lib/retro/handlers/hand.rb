module Retro
  module Handlers

    class Hand < Handler

      def call
        response = Client::Message.new("BL", "SI")
        user_items = ItemManager.hand(user)
        user_items.each_with_index do |item, idx|
          response.add floor_item_response(item, idx)
        end
        response.add 13.chr
        response.add Encoding::VL64.encode(user_items.count)
      end

      private

      def floor_item_response(floor_item, idx)
        [].tap do |list|
          list << 30.chr
          list << floor_item.id
          list << 30.chr
          list << idx
          list << 30.chr
          list << floor_item.hand_type
          list << 30.chr
          list << floor_item.id
          list << 30.chr
          list << floor_item.sprite
          list << 30.chr
          list << floor_item.width
          list << 30.chr
          list << floor_item.length
          list << 30.chr
          list << floor_item.col
          list << "/"
        end.join
      end

    end

  end
end