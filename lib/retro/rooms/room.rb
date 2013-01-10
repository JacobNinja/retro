require 'forwardable'

module Retro

  class Room
    extend Forwardable

    attr_reader :id, :name, :owner_id, :description, :status, :floor, :wallpaper

    delegate [:max_guests, :ccts, :model, :start_x, :start_y, :start_z] => :type

    def initialize(opts={})
      @id = opts[:id]
      @name = opts[:name]
      @owner_id = opts[:owner_id]
      @description = opts[:description]
      @type_id = opts[:type_id]
      @status = opts[:status]
      @type = opts[:type]
      @items = opts[:items]
      @floor = opts[:floor] || 0
      @wallpaper = opts[:wallpaper] || 0
    end

    def type
      @type ||= RoomTypeManager.find(@type_id)
    end

    def heightmap
      Client::Heightmap.new(type.heightmap).overlay(*items)
    end

    def owned_by?(user)
      self.owner_id == user.id
    end

    def items
      ItemManager.in_room(self)
    end

  end

end