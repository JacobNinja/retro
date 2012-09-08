module Retro

  class User

    attr_accessor :current_room, :x, :y, :z, :body_direction, :head_direction, :current_room_id
    attr_reader :name, :figure, :sex, :mission, :ph_tickets, :photo_film, :direct_mail, :id, :states

    def initialize(opts={})
      @name = opts[:name]
      @figure = opts[:figure]
      @sex = opts[:sex]
      @custom_data = opts[:mission]
      @ph_tickets = opts[:ph_tickets] || 0
      @photo_film = opts[:photo_film] || 0
      @direct_mail = opts[:direct_mail] || 0
      @id = opts[:id]
      @states = []
      @body_direction = 2
      @head_direction = 2
    end

    def greeting
      ClientMessage.new(:greeting)
    end

    def rooms
      Room.owned_by(self.id)
    end

    def add_rights_state
      @states << "flatctrl"
    end

  end

end