module Retro
  module Handlers

    class FlatPropByItem < Handler

      def call
        decoration_type, item_id = data.rest.split("/")

        item = ItemManager.find(item_id)
        if item
          if decoration_type == 'wallpaper'
            RoomManager.update_wall(user.current_room, item.furni_var)
          elsif decoration_type == 'floor'
            RoomManager.update_floor(user.current_room, item.furni_var)
          end
          body = "#{item.sprite}/#{item.furni_var}"
          ItemManager.delete(item)
          Client::Message.new("@n", body)
        end
      end

    end

  end
end