module Retro

  class FurniDefinition
    extend Attrs

    ATTRIBUTES = [:hand_type, :sprite, :width, :length, :col, :height, :flags, :var_type]

    attr_reader :id
    attr *ATTRIBUTES

    def initialize(opts={})
      @id = opts[:id]
      @opts = opts
      @flags = opts[:flags] || ""
    end

    def self.find_by_id(id)
      data = DB[:furni_definitions].first(:id => id)
      new(data) if data
    end

    module Flags

      def wall_item?
        flags.include? "V"
      end

      def path?
        flags.include? "P"
      end

      def sit?
        flags.include? "S"
      end

      def lay?
        flags.include? "L"
      end

      def stack?
        flags.include? "M"
      end

      def stack_on?
        flags.include? "O"
      end

      def roller?
        flags.include? "R"
      end

      def top_row?
        flags.include? "T"
      end

      def stand?
        flags.include? "W"
      end

      def teleport?
        flags.include? "X"
      end

      def sticky?
        flags.include? "N"
      end

      def decoration?
        flags.include? "D"
      end

      def auto_teleport?
        flags.include? "A"
      end

      def invisible?
        flags.include? "C"
      end

      def doormat?
        flags.include? "F"
      end

      def gift?
        flags.include? "G"
      end

    end

    module VarTypes

      NO_SIGN = 0
      OPEN = 1
      DIVIDER = 2
      DICE = 3
      TRUE_FALSE = 4
      ON_OFF = 5


      def divider?
        var_type == DIVIDER
      end

    end

    include Flags
    include VarTypes

  end

end