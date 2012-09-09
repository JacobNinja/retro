module Retro
  module Handlers

    class GoAway < Handler

      @header = "@R"

      def call
        user.states.clear
        super
      end

    end

  end
end