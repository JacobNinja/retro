module Retro

  class User

    attr_reader :name, :figure, :sex, :mission, :ph_tickets, :photo_film, :direct_mail, :id

    def initialize(opts={})
      @name = opts[:name]
      @figure = opts[:figure]
      @sex = opts[:sex]
      @custom_data = opts[:mission]
      @ph_tickets = opts[:ph_tickets] || 0
      @photo_film = opts[:photo_film] || 0
      @direct_mail = opts[:direct_mail] || 0
      @id = opts[:id]
    end

    def greeting
      ClientMessage.new(:greeting)
    end

    def rooms
      Room.owned_by(self.id)
    end

  end

end