module Retro

  class RoomType

    attr_reader :id, :max_guests, :heightmap, :ccts, :model, :guest, :start_x, :start_y, :start_z, :max_ascend, :max_descend, :user_type, :name

    def initialize(opts={})
      @id = opts[:id]
      @max_guests = opts[:max_guests]
      @heightmap = opts[:heightmap]
      @ccts = opts[:ccts]
      @model = opts[:model]
      @guest = opts[:guest]
      @start_x = opts[:start_x]
      @start_y = opts[:start_y]
      @start_z = opts[:start_z]
      @max_ascend = opts[:max_ascend]
      @max_descend = opts[:max_descend]
      @user_type = opts[:user_type]
      @name = opts[:name]
    end

    def guest?
      @guest == 1
    end

    def self.find_by_type_id(type_id)
      type_data = db.first(:id => type_id)
      new(type_data) if type_data
    end

    private

    def self.db
      DB[:room_types]
    end

  end

end