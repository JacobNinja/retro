module Retro
  module Handlers

    class Navigate < Handler

      def call
        hide_full = data.pop_vl64
        category_type = Encoding::VL64.decode(data.rest[0, data.rest.length - 1]) - 3
        response = Client::Message.new("C\\")
        categories = RoomCategory.of_type(category_type)
        categories.each do |category|
          response.add category_response(hide_full, category)
          category.rooms.each do |room|
            response.add room_response(room, category)
          end
        end
        response
        #response.add subcategory_response(hide_full)
      end

      private

      def category_response(hide_full, category)
        partial_response = [
          Encoding::VL64.encode(hide_full),
          Encoding::VL64.encode(category.id), # category id
          Encoding::VL64.encode(category.type), # room category type
          category.name,
          2.chr,
          Encoding::VL64.encode(0),
          Encoding::VL64.encode(10000),
          Encoding::VL64.encode(0), # parent category
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
            Encoding::VL64.encode(room.max_guests),
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
          Encoding::VL64.encode(room.max_guests),
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

      def subcategory_response(hide_full)
        [
          Encoding::VL64.encode(456), #subcategory id
          Encoding::VL64.encode(0), # idk
          "Subcategory name",
          2.chr,
          Encoding::VL64.encode(20), # current users
          Encoding::VL64.encode(200), # max users
          Encoding::VL64.encode(333), # parent category id
        ].join
      end

    end

  end
end