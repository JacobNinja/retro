module Retro
  module Handlers

    class Hand < Handler

      def call
        furni = Item.new(id: 1, hand_type: "S", sprite: "test", width: 1, length: 1, col: 1.5)
        response = ClientMessage.new("BL", "SI")
        response.add floor_item_response(furni, 0)
        response.add 13.chr
        response.add Encoding::VL64.encode(1)
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