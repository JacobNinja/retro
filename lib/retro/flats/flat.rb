module Retro

  class Flat

    attr_reader :room_id, :name, :owner, :max_guests, :description, :heightmap, :ccts, :model

    def initialize(opts={})
      @room_id = opts[:room_id]
      @name = opts[:name]
      @owner = opts[:owner]
      @max_guests = opts[:max_guests]
      @description = opts[:description]
      @heightmap = opts[:heightmap]
      @ccts = opts[:ccts]
      @model = opts[:model]
    end

  end

end