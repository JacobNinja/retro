require 'forwardable'

module Retro

  class Room
    extend Forwardable

    attr_reader :id, :name, :owner_id, :description, :status

    delegate [:max_guests, :ccts, :model, :start_x, :start_y, :start_z] => :type

    def initialize(opts={})
      @id = opts[:id]
      @name = opts[:name]
      @owner_id = opts[:owner_id]
      @description = opts[:description]
      @type_id = opts[:type_id]
      @status = opts[:status]
    end

    def type
      @type ||= RoomType.find_by_type_id(@type_id)
    end

    def heightmap
      Client::Heightmap.new(type.heightmap).overlay(*items)
    end

    def owned_by?(user)
      self.owner_id == user.id
    end

    def items
      Item.floor_items_in_room(self.id)
    end

    def update_category(category)
      DB[:rooms].where(id: self.id).update(category_id: category.id)
      @category_id = category.id
    end

    def update_description(description)
      DB[:rooms].where(id: self.id).update(description: description)
      @description = description
    end

    def self.create(name, user, type, status)
      new_id = DB[:rooms].insert(name: name, owner_id: user.id, type_id: type.id, category_id: 4, status: status)
      find_by_id(new_id)
    end

    def self.find_by_id(room_id)
      data = db.first(:id => room_id)
      if data
        room = new(data)
        if block_given?
          yield room
        else
          room
        end
      else
        nil
      end
    end

    def self.owned_by(owner_id)
      db.filter(:owner_id => owner_id).map {|data| new(data) }
    end

    def self.by_category(category_id)
      db.filter(category_id: category_id).map {|data| new(data) }
    end

    private

    def self.db
      DB[:rooms]
    end

  end

end