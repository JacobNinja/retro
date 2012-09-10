module Retro
  module Handlers

    class Navigate < Handler

      def call
        hide_full = data.pop_vl64
        category_id = Encoding::VL64.decode(data.rest[0, data.rest.length - 1])
        response = Client::Message.new("C\\")
        category = RoomCategory.find_by_id(category_id)
        response.add category_response(hide_full, category)
        category.rooms.each do |room|
          response.add room_response(room, category)
        end
        category.subcategories.each do |subcategory|
          response.add subcategory_response(hide_full, subcategory)
        end
        response
      end

      private

      def category_response(hide_full, category)
        partial_response = [
          Encoding::VL64.encode(hide_full),
          Encoding::VL64.encode(category.id),
          Encoding::VL64.encode(category.type),
          category.name,
          2.chr,
          Encoding::VL64.encode(0),
          Encoding::VL64.encode(10000),
          Encoding::VL64.encode(category.parent || 0),
        ]
        partial_response << Encoding::VL64.encode(category.rooms.count) if category.guest?
        partial_response.join
      end

      def private_room_response(room)
        [
            Encoding::VL64.encode(room.id),
            room.name,
            2.chr,
            "room owner",
            2.chr,
            room.status,
            2.chr,
            Encoding::VL64.encode(10), #current users
            Encoding::VL64.encode(25),
            room.description,
            2.chr
        ]
      end

      def public_room_response(room, category_id)
        [
          Encoding::VL64.encode(room.id), # room id
          Encoding::VL64.encode(1), # room id
          room.name,
          2.chr,
          Encoding::VL64.encode(10), # current users
          Encoding::VL64.encode(room.max_guests || 25),
          Encoding::VL64.encode(category_id),
          room.description,
          2.chr,
          Encoding::VL64.encode(room.id), # room id
          Encoding::VL64.encode(0),
          room.ccts,
          2.chr,
          Encoding::VL64.encode(0),
          Encoding::VL64.encode(1),
        ].join
      end

      def room_response(room, category)
        if category.guest?
          private_room_response(room)
        else
          public_room_response(room, category.id)
        end
      end

      def subcategory_response(hide_full, subcategory)
        [
          Encoding::VL64.encode(subcategory.id), #subcategory id
          Encoding::VL64.encode(0), # idk
          subcategory.name,
          2.chr,
          Encoding::VL64.encode(20), # current users
          Encoding::VL64.encode(200), # max users
          Encoding::VL64.encode(subcategory.parent || 0), # parent category id
        ].join
      end

    end

  end
end