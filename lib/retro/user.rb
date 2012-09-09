module Retro

  class UserState

    def initialize
      @states = []
    end

    def dance
      @states << "dance" unless @states.include? "dance"
    end

    def dance!
      @states.delete("dance")
    end

    def wave
      @states << "wave" unless @states.include? "wave"
    end

    def wave!
      @states.delete("wave")
    end

    def add_rights
      @states << "flatctrl" unless @states.include? "flatctrl"
    end

    def clear
      @states.clear
    end

    def build
      @states.inject("") do |status, state|
        status + "/#{state}"
      end
    end

  end

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
      @states = UserState.new
      @body_direction = 2
      @head_direction = 2
    end

    def greeting
      Client::Message.new(:greeting)
    end

    def rooms
      Room.owned_by(self.id)
    end

  end

end