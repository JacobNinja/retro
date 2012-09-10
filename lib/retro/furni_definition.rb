module Retro

  class FurniDefinition

    attr_reader :id, :hand_type, :sprite, :width, :length, :col, :furni_var, :height, :flags

    def initialize(opts={})
      @id = opts[:id]
      @hand_type = opts[:hand_type]
      @sprite = opts[:sprite]
      @width = opts[:width]
      @length = opts[:length]
      @height = opts[:height]
      @col = opts[:col]
      @furni_var = opts[:furni_var]
      @flags = opts[:flags]
    end

    def self.find_by_id(id)
      data = DB[:furni_definitions].first(:id => id)
      new(data) if data
    end

    def wall_item?
      flags.include? "V"
    end

  end

end