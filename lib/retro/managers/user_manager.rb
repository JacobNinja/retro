module Retro

  class UserManager

    extend Query

    def self.authenticate(username, password)
      filter(name: username, password: password).first
    end

    def initialize(user)
      @user = user
    end

    def enter(room, room_id)
      @user.current_room = room
      @user.current_room_id = room_id
      @user.states.rights if room.owned_by?(@user)
    end

    def leave
      @user.states.clear
      @user.current_room = nil
      @user.current_room_id = nil
    end

    def move(x, y)
      heightmap = @user.current_room.heightmap
      return nil unless heightmap.move_to?(x, y)
      directions = Retro::PathFinder.new(heightmap).directions(@user.x, @user.y, x, y)
      return nil unless directions

      @user.states.sit!

      Enumerator.new do |yielder|
        directions.each do |(x, y)|
          z = @user.current_room.heightmap.new_item_height(x, y)
          body_movement = next_body_movement(x, y)
          @user.body_direction = body_movement
          @user.head_direction = body_movement
          @user.states.move(x, y, z)
          yielder << @user
          @user.x = x
          @user.y = y
          @user.z = z
        end
        @user.states.move!
        top_item = @user.current_room.heightmap.top_item_at(@user.x, @user.y)
        if top_item && top_item.sit?
          @user.states.sit(@user.z + top_item.action_height)
          @user.body_direction = top_item.rotation
          @user.head_direction = top_item.rotation
        end
        yielder << @user
      end
    end

    private

    def next_body_movement(x, y)
      if x == (@user.x - 1)
        if y == (@user.y + 1)
         5 # LD
        elsif y == (@user.y - 1)
         7 # LU
        else
         6 # left
        end
      elsif x == (@user.x + 1)
        if y == (@user.y + 1)
         3 # RD
        elsif y == (@user.y - 1)
         1 # UR
        else
         2 # Right
        end
      elsif y == (@user.y - 1)
       0 # up
      elsif y == (@user.y + 1)
       4 # down
      else
       0
      end
    end

    def self.repository
      Repository.users
    end

  end

end