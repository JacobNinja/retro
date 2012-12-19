module Retro

  class RoomManager

    extend Query

    def self.create(name, owner, type, status)
      super(name: name, owner_id: owner.id, type_id: type.id, status: status, category_id: 4)
    end

    def self.update_category(id, category)
      update(id, category_id: category.id)
    end

    def self.owned_by(user)
      filter(owner_id: user.id)
    end

    def self.by_category(category)
      filter(category_id: category.id)
    end

    def initialize(room)
      @room = room
    end

    def move(item_id, x, y, rotation)
      item = @room.items.find {|room_item| room_item.id == item_id }
      return nil if item.nil? || @room.heightmap.blocked?(x, y, item)

      z = @room.heightmap.new_item_height(x, y)
      update_params = {x: x, y: y, z: z, rotation: rotation, room_id: @room.id}
      items_repository.update(item_id, update_params)
      item.update(update_params)
    end

    private

    def self.repository
      Repository.rooms
    end

    def items_repository
      Repository.items
    end

  end

end