module Retro
  module Client

    class Heightmap

      attr_reader :heightmap

      def initialize(heightmap)
        @heightmap = heightmap
      end

      def overlay(*items)
        overlayed_heightmap = items.inject(@heightmap) do |heightmap, item|
          heightmap.split("|").map.with_index do |row, y|
            row.each_char.map.with_index do |char, x|
              if item.within?(x, y)
                item_heightmap_token(item, char)
              else
                char
              end
            end.join
          end.join("|")
        end
        self.class.new(overlayed_heightmap)
      end

      BLOCKED = "A"

      def item_heightmap_token(item, current_value)
        token = "0"
        token = BLOCKED unless (item.stack_on? || item.sit? || item.lay? || item.stand?) || item.open?
        token = BLOCKED if item.divider? && !item.open?
        token
      end

      def blocked?(x, y)
        row = @heightmap.split("|")[y]
        row[x] == BLOCKED
      end

    end

  end
end