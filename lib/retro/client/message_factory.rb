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
          post_status = ""
          post_status << "/#{user.states.first}" unless user.states.empty? # TODO Add multiple states
          ClientMessage.new("@b", "#{user.current_room_id} #{x},#{y},#{z},#{head_direction},#{body_direction}#{post_status}#{13.chr}")
        end

      end

    end

  end

end