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

      Enumerator.new do |yielder|
        Retro::PathFinder.new(heightmap).directions(@user.x, @user.y, x, y).each do |(x, y, z)|
          z ||= 0
          @user.states.move(x, y, z)
          yielder << @user
          @user.x = x
          @user.y = y
          @user.z = z
        end
        @user.states.move!
        yielder << @user
      end
    end

    private

    def self.repository
      Repository.users
    end

  end

end