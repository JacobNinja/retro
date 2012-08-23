module Retro

  class Item

    attr_reader :id, :hand_type, :sprite, :width, :length, :col

    def initialize(opts={})
      @id = opts[:id]
      @hand_type = opts[:hand_type]
      @sprite = opts[:sprite]
      @width = opts[:width]
      @length = opts[:length]
      @col = opts[:col]
    end

  end

end