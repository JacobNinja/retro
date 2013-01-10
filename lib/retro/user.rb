module Retro

  class UserState

    STATES = {
        dance: -> { "dance" },
        wave: -> { "wave" },
        rights: -> { "flatctrl" },
        move: -> x, y, z { "mv #{x},#{y},#{z}" },
        drink: -> drink { "carryd #{drink}" },
        sit: -> z { "sit #{z.to_f}" }
    }

    def initialize
      @states = {}
    end

    def clear
      @states.clear
    end

    def build
      @states.values.inject("") do |status, state|
        status + "/#{state}"
      end
    end

    STATES.each do |(state, proc)|
      define_method(state) {|*args| @states.merge!(state => proc.call(*args)) }
      define_method(:"#{state}!") { @states.delete(state) }
      define_method(:"#{state}?") { @states.has_key?(state) }
    end

  end

  class User

    extend Attrs

    attr :id, :name, :figure, :sex, :mission, :ph_tickets, :photo_film, :direct_mail, :x, :y, :z
    attr_accessor :body_direction, :head_direction, :current_room_id, :current_room
    attr_reader :states
    attr_writer :x, :y, :z

    def initialize(opts={})
      @opts = opts
      @ph_tickets = opts[:ph_tickets] || 0
      @photo_film = opts[:photo_film] || 0
      @direct_mail = opts[:direct_mail] || 0
      @body_direction = 2
      @head_direction = 2
      @states = UserState.new
    end

    def rooms
      RoomManager.owned_by(self)
    end

    def custom_data
      self.mission
    end

  end

end