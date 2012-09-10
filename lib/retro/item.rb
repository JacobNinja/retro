require "forwardable"

module Retro

  class Item
    extend Forwardable

    attr_reader :id, :furni_definition_id, :user_id, :rotation, :x, :y, :room_id, :teleport_id, :furni_var

    delegate FurniDefinition::ATTRIBUTES + FurniDefinition::Flags.instance_methods(false) + FurniDefinition::VarTypes.instance_methods(false) => :furni_definition

    def initialize(opts={})
      @id = opts[:id]
      @furni_definition_id = opts[:furni_definition_id]
      @user_id = opts[:user_id]
      @room_id = opts[:room_id]
      @rotation = opts[:rotation] || 0
      @teleport_id = opts[:teleport_id] || 0
      @x = opts[:x]
      @y = opts[:y]
      @furni_var = opts[:furni_var]
    end

    def furni_definition
      @furni_definition ||= FurniDefinition.find_by_id(@furni_definition_id) if @furni_definition_id
    end

    def in_room?
      !room_id.nil?
    end

    def within?(x, y)
      if length == 1 && width == 1
        @x == x && @y == y
      elsif length == 2
        if rotation % 4 == 0
          (x == @x || x == @x + (length - 1)) && y == @y
        else
          (y == @y || y == @y + (length - 1)) && x == @x
        end
      elsif width == 2
        if rotation % 4 == 0
          (x == @x || x == @x + (width - 1)) && y == @y
        else
          (y == @y || y == @y + (width - 1)) && x == @x
        end
      end
    end

    def set_position(room_id, x, y, rotation=0)
      update_room(room_id, x, y, rotation)
      @room_id = room_id
      @x = x
      @y = y
      @rotation = rotation
    end

    def update_furni_var(furni_var)
      DB[:items].where(id: self.id).update(furni_var: furni_var)
      @furni_var = furni_var
    end

    def open?
      @furni_var == "O"
    end

    def reset_room
      set_position(nil, nil, nil, nil)
    end

    def update_room(room_id, x, y, rotation)
      DB[:items].where(:id => self.id).update(room_id: room_id, x: x, y: y, rotation: rotation)
    end

    def self.create(user, furni_definition)
      DB[:items].insert(user_id: user.id, furni_definition_id: furni_definition.id)
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