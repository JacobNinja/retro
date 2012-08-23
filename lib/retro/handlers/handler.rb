module Retro
  module Handlers

    class Handler

      attr_reader :data

      def initialize(session, data)
        @session = session
        @data = data
      end

      def call
        ClientMessage.new(header, body)
      end

      def header
        self.class.instance_variable_get("@header")
      end

      def body
        self.class.instance_variable_get("@body")
      end

      def user
        @session.user
      end

      def private_room_response(hide_full)
        [].tap do |list|
          list << Encoding::VL64.encode(123) # room id
          list << "RoomName"
          list << 2.chr
          list << "-" # Room owner
          list << 2.chr
          list << "RoomStatus"
          list << 2.chr
          list << Encoding::VL64.encode(10) # current users
          list << Encoding::VL64.encode(25)
          list << "Room description"
          list << 2.chr
        end.join
      end

    end

  end
end