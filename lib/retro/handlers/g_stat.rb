module Retro
  module Handlers

    class GStat < Handler

      def call
        room = user.current_room
        user.x = room.start_x
        user.y = room.start_y
        user.z = room.start_z
        [
            ClientMessage.new("@\\", get_user_entry_packet),
            ClientMessage.new("@j"), # rights
            ClientMessage.new("@o"), # admin rights ?
            Client::MessageFactory.room_movement(user)
        ]
      end

      private

      def get_user_entry_packet
        [
          "i:#{user.current_room_id}" + 13.chr,
          "n:#{user.name}" + 13.chr,
          "f:hr-681-31.hd-180-7.ch-240-84.lg-270-90.sh-908-66.ea-1404-74" + 13.chr,
          "l:#{user.x} #{user.y} #{user.z}" + 13.chr,
          "s:#{user.sex}" + 13.chr,
          "c:mission" + 13.chr,
        ].join
      end

    end

  end
end