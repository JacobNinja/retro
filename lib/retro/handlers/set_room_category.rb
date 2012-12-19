module Retro
  module Handlers

    class SetRoomCategory < Handler

      def call
        room_id = data.pop_vl64
        category_id = data.pop_vl64
        category = RoomCategoryManager.find(category_id)
        RoomManager.update_category(room_id, category) if category

        nil
      end

    end

  end
end