module Retro
  module Handlers

    class GoAway < Handler

      @header = "@R"

      def call
        user_manager.leave
        super
      end

    end

  end
end