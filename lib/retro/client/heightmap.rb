module Retro
  module Client

    class Heightmap

      BLOCKED = "A"
      OFF_GRID = "x"

      attr_reader :heightmap

      def initialize(heightmap, items=[])
        @heightmap = heightmap
        @items = items
      end

      def overlay(*items)
        overlayed_heightmap = heightmap_data.map.with_index do |row, y|
          row.map.with_index do |char, x|
            items_at_point = items_at(x, y, items)
            if items_at_point.empty?
              char
            else
              heightmap_token(items_at_point)
            end
          end.join
        end.join("|")
        self.class.new(overlayed_heightmap, @items + items)
      end

      def heightmap_token(items)
        top_item = items.max_by(&:z)
        if top_item.divider?
          top_item.open? ? "O" : BLOCKED
        elsif !top_item.move_to? && !top_item.stack_on?
          BLOCKED
        elsif top_item.stack_on?
          top_item.z.round.to_s
        else
          "0"
        end
      end

      def new_item_height(x, y)
        top_item = top_item_at(x, y)
        top_item ? (top_item.z + top_item.height) : 0
      end

      def items_at(x, y, items=@items)
        items.select do |item|
          item.within?(x, y)
        end
      end

      def neighbors(x, y)
        surrounding(x, y).reject do |(x, y)|
          top_item = top_item_at(x, y)
          outside_grid?(x, y) || blocked?(x, y) || (top_item && !top_item.stand?)
        end
      end

      def surrounding(x, y)
        [[x - 1, y - 1],
        [x - 1,  y],
        [x - 1, y +1],
        [x, y - 1],
        [x, y + 1],
        [x + 1, y - 1],
        [x + 1, y],
        [x + 1, y + 1]]
      end

      def outside_grid?(x, y)
        tile = tile_at(x, y)
        x < 0 || y < 0 || tile.nil? || tile == OFF_GRID
      end

      def blocked?(x, y, item=nil)
        tile_blocked_status?(x, y) || !movable_top_item_at?(x, y)
      end

      def move_to?(x, y)
        item = top_item_at(x, y)
        !tile_blocked_status?(x, y) && (item.nil? || item.sit? || item.lay? || item.stand?)
      end

      def top_item_at(x, y)
        items_at(x, y).max_by(&:z)
      end

      def movable_top_item_at?(x, y)
        items = items_at(x, y)
        max_item = items.max_by(&:z)
        !max_item || max_item.move_to? || max_item.stack_on? || max_item.stand?
      end

      def tile_blocked_status?(x, y)
        tile_at(x, y) == BLOCKED
      end

      def tile_at(x, y)
        row = heightmap_data[y]
        row[x] if row
      end

      def heightmap_data
        @heightmap_data ||= heightmap.split("|").map {|row| row.each_char.to_a }
      end

    end

  end
end