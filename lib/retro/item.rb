require "forwardable"

module Retro

  class Item
    extend Forwardable

    attr_reader :id, :furni_definition_id, :user_id, :rotation, :x, :y, :room_id, :teleport_id

    delegate FurniDefinition.instance_methods(false) => :furni_definition

    def initialize(opts={})
      @id = opts[:id]
      @furni_definition_id = opts[:furni_definition_id]
      @user_id = opts[:user_id]
      @room_id = opts[:room_id]
      @rotation = opts[:rotation] || 0
      @teleport_id = opts[:teleport_id] || 0
      @x = opts[:x]
      @y = opts[:y]
    end

    def furni_definition
      FurniDefinition.find_by_id(@furni_definition_id) if @furni_definition_id
    end

    def in_room?
      !room_id.nil?
    end

    def set_position(room_id, x, y)
      update_room(room_id, x, y)
      @room_id = room_id
      @x = x
      @y = y
    end

    def reset_room
      update_room(nil, nil, nil)
      @room_id = nil
      @x = nil
      @y = nil
    end

    def update_room(room_id, x, y)
      DB[:items].where(:id => self.id).update(room_id: room_id, x: x, y: y)
    end

    def self.floor_items_in_room(room_id)
      DB[:items].filter(room_id: room_id).map {|data| new(data) }.reject &:wall_item?
    end

    def self.find_by_id(id)
      data = DB[:items].first(:id => id)
      if data
        item = new(data)
        if block_given?
          yield item
        else
          item
        end
      else
        nil
      end
    end

    def self.by_user(user_id)
      DB[:items].filter(:user_id => user_id).map {|data| new(data) }
    end

  end

end