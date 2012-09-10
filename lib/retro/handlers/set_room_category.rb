module Retro
  module Handlers

    class SetRoomCategory < Handler

      def call
        room_id = data.pop_vl64
        category_id = data.pop_vl64
        room = Room.find_by_id(room_id)
        category = RoomCategory.find_by_id(category_id)

        room.update_category(category) if room && category

        nil
      end

    end

  end
end