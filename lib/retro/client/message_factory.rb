module Retro

  module Client

    class MessageFactory

      class << self

        def room_movement(user, opts={})
          x = opts[:x] || user.x
          y = opts[:y] || user.y
          z = opts[:z] || user.z
          head_direction = opts[:head_direction] || user.head_direction
          body_direction = opts[:body_direction] || user.body_direction
          Client::Message.new("@b", "#{user.current_room_id} #{x},#{y},#{z},#{head_direction},#{body_direction}#{user.states.build}#{13.chr}")
        end

      end

    end

  end

end