module Retro
  module Handlers

    class UserFlatCats < Handler

      def call
        room_categories = RoomCategoryManager.of_type(2)
        response = Client::Message.new("C]", Encoding::VL64.encode(room_categories.count))
        room_categories.each do |room_category|
          response.add private_category_response(room_category)
        end
        response
      end

      private

      def private_category_response(room_category)
        [
          Encoding::VL64.encode(room_category.id),
          room_category.name,
          2.chr,
        ].join
      end

    end
  end
end