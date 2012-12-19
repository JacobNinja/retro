module Retro

  class ItemManager

    extend Query

    def self.create(user, furni_definition)
      super(user_id: user.id, furni_definition_id: furni_definition.id)
    end

    def self.pickup(id)
      update(id, x: nil, y: nil, z: nil, rotation: nil, room_id: nil)
    end

    def self.in_room(room)
      filter(room_id: room.id).reject(&:wall_item?)
    end

    def self.hand(user)
      filter(user_id: user.id).reject(&:in_room?)
    end

    def self.sign(id, sign_data)
      update(id, furni_var: sign_data)
    end

    def initialize(item)
      @item = item
    end

    def place(room, x, y, z)
      self.class.update(@item.id, room_id: room.id, x: x, y: y, z: z)
    end

    private

    def self.repository
      Repository.items
    end

  end

end