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
      RoomManager.by_category(self)
    end

    def subcategories
      RoomCategoryManager.subcategories(self)
    end

  end

end