module Retro
  class Repository

    def initialize(klass, table_name)
      @klass = klass
      @table_name = table_name
    end

    def find(id)
      data = db.first(:id => id)
      @klass.new(data) if data
    end

    def update(id, attrs)
      db.where(:id => id).update(attrs)
    end

    def create(attrs)
      new_id = db.insert(attrs)
      find(new_id)
    end

    def filter(attrs)
      db.filter(attrs).map {|data| @klass.new(data) }
    end

    def delete(id)
      db.filter(id: id).delete
    end

    def all
      db.all.map {|data| @klass.new(data) }
    end

    def db
      DB[@table_name]
    end

    def self.items
      new(Item, :items)
    end

    def self.room_categories
      new(RoomCategory, :room_categories)
    end

    def self.room_types
      new(RoomType, :room_types)
    end

    def self.rooms
      new(Room, :rooms)
    end

    def self.furni_definitions
      new(FurniDefinition, :furni_definitions)
    end

    def self.catalog_items
      new(CatalogItem, :catalog_items)
    end

    def self.catalog_pages
      new(CatalogPage, :catalog_pages)
    end

    def self.users
      new(User, :users)
    end

  end
end