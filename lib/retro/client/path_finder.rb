module Retro

  class PathFinder

    def initialize(heightmap)
      @heightmap = heightmap
    end

    def directions(start_x, start_y, end_x, end_y)
      Enumerator.new do |y|
        Array(route_to(start_x, start_y, end_x, end_y)).each do |route|
          y << route
        end
      end
    end

    def route_to(start_x, start_y, end_x, end_y, path=[], last_routes=[])
      possible_routes = sorted_routes(start_x, start_y, end_x, end_y)
      if r = possible_routes.find {|route| route == [end_x, end_y]}
        return path + [[*r, @heightmap.new_item_height(*r)]]
      else
        possible_routes.each do |(possible_x, possible_y)|
          next if last_routes.include? [possible_x, possible_y]
          new_path = path + [[possible_x, possible_y, @heightmap.new_item_height(possible_x, possible_y)]]
          used_routes = (last_routes + possible_routes).uniq
          new_route = route_to(possible_x, possible_y, end_x, end_y, new_path, used_routes)
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