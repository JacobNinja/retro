module Retro

  class PathFinder

    def initialize(heightmap)
      @heightmap = heightmap
      @closed = []
    end

    def directions(start_x, start_y, end_x, end_y, path=[])
      possible_routes = sorted_routes(start_x, start_y, end_x, end_y)
      if r = possible_routes.find {|route| route == [end_x, end_y]}
        return path + [[*r]]
      else
        possible_routes.each do |(possible_x, possible_y)|
          next if @closed.include?([possible_x, possible_y]) || !@heightmap.move_through?(possible_x, possible_y)
          new_path = path + [[possible_x, possible_y]]
          @closed << [possible_x, possible_y] unless @closed.include?([possible_x, possible_y])
          new_route = directions(possible_x, possible_y, end_x, end_y, new_path)
          return new_route if new_route
        end
      end
      nil
    end

    def sorted_routes(start_x, start_y, end_x, end_y)
      @heightmap.neighbors(start_x, start_y).sort_by do |(x, y)|
        (end_x - x).abs + (end_y - y).abs
      end
    end

  end

end