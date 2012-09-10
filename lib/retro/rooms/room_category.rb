module Retro

  class RoomCategory

    attr_reader :id, :type, :name, :parent

    def initialize(opts={})
      @id = opts[:id]
      @type = opts[:type]
      @name = opts[:name]
      @parent = opts[:parent]
    end

    def guest?
      type == 2
    end

    def rooms
      Room.by_category(id)
    end

    def subcategories
      self.class.by_parent_id(self.id)
    end

    def self.by_parent_id(parent_id)
      DB[:room_categories].filter(parent: parent_id).map {|data| new(data) }
    end

    def self.find_by_id(id)
      data = DB[:room_categories].first(id: id)
      new(data) if data
    end

    def self.of_type(type)
      DB[:room_categories].filter(type: type).map {|data| new(data) }
    end

    def self.all
      DB[:room_categories].all.map {|data| new(data) }
    end

  end

end