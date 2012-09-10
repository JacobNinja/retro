module Retro
  module Handlers

    class GoAway < Handler

      @header = "@R"

      def call
        user.leave_room
        super
      end

    end

  end
end