module Retro

  class RoomTypeManager

    extend Query

    def self.find_by_model(model)
      filter(model).first
    end

    private

    def self.repository
      Repository.room_types
    end

  end

end