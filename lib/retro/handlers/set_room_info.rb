module Retro
  module Handlers

    class SetRoomInfo < Handler

      def call
        _, room_id, room_details = data.rest.split("/")
        Room.find_by_id(room_id) do |room|
          room.update_description(get_room_detail(room_details, "description"))
        end
        nil
      end

      def get_room_detail(room_details, attr)
        room_details.split("\r").each do |detail|
          if detail.start_with? "#{attr}="
            return detail.slice(attr.length + 1, detail.length)
          end
        end
      end

    end

  end
end