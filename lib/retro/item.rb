require "forwardable"

module Retro

  class Item
    extend Forwardable
    extend Attrs

    attr :id, :furni_definition_id, :user_id, :room_id, :x, :y, :z, :furni_var

    PROPERTIES_TO_DELEGATE = FurniDefinition::ATTRIBUTES + FurniDefinition::Flags.instance_methods(false) + FurniDefinition::VarTypes.instance_methods(false)
    delegate PROPERTIES_TO_DELEGATE => :furni_definition

    def initialize(opts={})
      @opts = opts
    end

    def update(new_opts)
      self.class.new(@opts.merge(new_opts))
    end

    def rotation
      @opts[:rotation] || 0
    end

    def teleport_id
      @opts[:teleport_id] || 0
    end

    def furni_definition
      @furni_definition ||= FurniDefinitionManager.find(self.furni_definition_id) if self.furni_definition_id
    end

    def in_room?
      !room_id.nil?
    end

    def within?(x, y)
      if length == 1 && width == 1
        self.x == x && self.y == y
      elsif length == 2
        if rotation % 4 == 0
          (x == self.x || x == self.x + (length - 1)) && y == self.y
        else
          (y == self.y || y == self.y + (length - 1)) && x == self.x
        end
      elsif width == 2
        if rotation % 4 == 0
          (x == self.x || x == self.x + (width - 1)) && y == self.y
        else
          (y == self.y || y == self.y + (width - 1)) && x == self.x
        end
      end
    end

    def z
      @opts[:z] || 0.0
    end

    def open?
      self.furni_var == "O"
    end

    def interactable?
      self.stack_on? || self.move_to?
    end

    def move_to?
      self.sit? || self.lay? || self.stand? || self.open? || self.path?
    end

  end

end