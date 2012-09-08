module Retro
  module Handlers

    class GoAway < Handler

      def call
        user.states.clear
        ClientMessage.new("@R")
      end

    end

  end
end