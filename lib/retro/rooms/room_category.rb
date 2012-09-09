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

    def self.of_type(type)
      DB[:room_categories].filter(:type => type).map {|data| new(data) }
    end

  end

end