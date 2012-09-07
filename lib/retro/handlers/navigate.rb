module Retro
  module Handlers

    class Navigate < Handler

      def call
        hide_full = data.pop_vl64
        category_id = Encoding::VL64.decode(data.rest[0, data.rest.length - 1])
        response = ClientMessage.new("C\\")
        public_category_1 = RoomCategory.new(id: 3, type: 0, name: "Category 1", parent: 0)
        public_category_2 = RoomCategory.new(id: 4, type: 0, name: "Category 2", parent: 0)
        heightmap = 'xxxxxxxxxxxxxxxx000000|xxxxx0xxxxxxxxxx000000|xxxxx00000000xxx000000|xxxxx000000000xx000000|0000000000000000000000|0000000000000000000000|0000000000000000000000|0000000000000000000000|0000000000000000000000|xxxxx000000000000000xx|xxxxx000000000000000xx|x0000000000000000000xx|x0000000000000000xxxxx|xxxxxx00000000000xxxxx|xxxxxxx0000000000xxxxx|xxxxxxxx000000000xxxxx|xxxxxxxx000000000xxxxx|xxxxxxxx000000000xxxxx|xxxxxxxx000000000xxxxx|xxxxxxxx000000000xxxxx|xxxxxxxx000000000xxxxx|xxxxxx00000000000xxxxx|xxxxxx00000000000xxxxx|xxxxxx00000000000xxxxx|xxxxxx00000000000xxxxx|xxxxxx00000000000xxxxx|xxxxx000000000000xxxxx|xxxxx000000000000xxxxx'
        ccts = 'hh_room_nlobby'
        public_room = Flat.new(room_id: 1, name: "Welcome Lounge", description: "test", max_guests: 100,
                               heightmap: heightmap, ccts: ccts, model: 'newbie_lobby')
        categories = [public_category_1, public_category_2]
        selected_category = categories.find { |cat| cat.id == category_id }
        response.add category_response(hide_full, selected_category)
        response.add public_room_response(public_room, selected_category.id)
        #response.add subcategory_response(hide_full)
      end

      private

      def category_response(hide_full, category)
        [].tap do |list|
          list.push Encoding::VL64.encode(hide_full)
          list.push Encoding::VL64.encode(category.id) # category id
          list.push Encoding::VL64.encode(category.type) # room category type
          list.push category.name
          list.push 2.chr
          list.push Encoding::VL64.encode(0)
          list.push Encoding::VL64.encode(10000)
          list.push Encoding::VL64.encode(category.parent) # parent category
          #list.push Encoding::VL64.encode(10) # room count
        end.join
      end

      def public_room_response(room, category_id)
        [].tap do |list|
          list << Encoding::VL64.encode(room.room_id) # room id
          list << Encoding::VL64.encode(1) # room id
          list << room.name
          list << 2.chr
          list << Encoding::VL64.encode(10) # current users
          list << Encoding::VL64.encode(room.max_guests)
          list << Encoding::VL64.encode(category_id)
          list << room.description
          list << 2.chr
          list << Encoding::VL64.encode(room.room_id) # room id
          list << Encoding::VL64.encode(0)
          list << room.ccts
          list << 2.chr
          list << Encoding::VL64.encode(0)
          list << Encoding::VL64.encode(1)
        end.join
      end

      def subcategory_response(hide_full)
        [].tap do |list|
          list << Encoding::VL64.encode(456) #subcategory id
          list << Encoding::VL64.encode(0) # idk
          list << "Subcategory name"
          list << 2.chr
          list << Encoding::VL64.encode(20) # current users
          list << Encoding::VL64.encode(200) # max users
          list << Encoding::VL64.encode(333) # parent category id
        end.join
      end

    end

  end
end