module Retro

  class Item

    attr_reader :id, :hand_type, :sprite, :width, :length, :col, :rotation, :furni_var, :teleport_id, :height

    def initialize(opts={})
      @id = opts[:id]
      @hand_type = opts[:hand_type]
      @sprite = opts[:sprite]
      @width = opts[:width]
      @length = opts[:length]
      @height = opts[:height]
      @col = opts[:col]
      @rotation = opts[:rotation]
      @furni_var = opts[:furni_var]
      @teleport_id = opts[:teleport_id]
    end

  end

end