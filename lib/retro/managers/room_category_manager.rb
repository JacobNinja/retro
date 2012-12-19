module Retro

  class RoomCategoryManager

    extend Query

    def self.of_type(type)
      filter(type: type)
    end

    def self.subcategories(category)
      filter(parent: category.id)
    end

    private

    def self.repository
      Repository.room_categories
    end

  end

end