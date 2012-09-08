require 'forwardable'

module Retro

  class Room
    extend Forwardable

    attr_reader :id, :name, :owner, :max_guests, :description, :heightmap, :ccts, :model, :status

    delegate [:max_guests, :heightmap, :ccts, :model] => :type

    def initialize(opts={})
      @id = opts[:id]
      @name = opts[:name]
      @owner = opts[:owner]
      @description = opts[:description]
      @type_id = opts[:type_id]
      @status = opts[:status]
    end

    def type
      RoomType.find_by_type_id(@type_id) if @type_id
    end

    def self.find_by_id(room_id)
      room = db.first(:id => room_id)
      if room && block_given?
        yield new(room)
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