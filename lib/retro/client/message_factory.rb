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
          Client::Message.new("@b", "#{user.current_room_id} #{x},#{y},#{z},#{body_direction},#{head_direction}#{user.states.build}#{13.chr}")
        end

        def user_details(user)
          packet = {
              "name" => user.name,
              "figure" => user.figure,
              "sex" => user.sex,
              "customData" => user.mission,
              "ph_tickets" => user.ph_tickets,
              "photo_film" => user.photo_film,
              "directMail" => user.direct_mail
          }
          Client::Message.new("@E", packet.map {|(k, v)| "#{k}=#{v}"}.join("\r") + "\r")
        end

        def heightmap(room)
          adjusted_heightmap = room.heightmap.heightmap.gsub("|", "\r")
          Client::Message.new("@_", adjusted_heightmap)
        end

      end

    end

  end

end