module Retro

  class User

    attr_reader :name, :figure, :sex, :custom_data, :ph_tickets, :photo_film, :direct_mail

    def initialize(opts={})
      @name = opts[:name]
      @figure = opts[:figure]
      @sex = opts[:sex]
      @custom_data = opts[:custom_data]
      @ph_tickets = opts[:ph_tickets]
      @photo_film = opts[:photo_film]
      @direct_mail = opts[:direct_mail]
    end

    def greeting
      ClientMessage.new(:greeting)
    end

  end

end