module Retro
  module Handlers

    class Pickup < Handler

      def call
        keyword, item_type, id = data.rest.split(" ")
        if keyword == "new"
          if item_type == "stuff"
            pickup_floor_stuff(id)
          elsif item_type == "item"
            pickup_wall_stuff(id)
          end
        end
      end

      def pickup_floor_stuff(id)
        Item.find_by_id(id) do |item|
          item.reset_room
          Client::Message.new("A^", item.id.to_s)
        end
      end

      def pickup_wall_stuff(id)

      end

    end

  end
end