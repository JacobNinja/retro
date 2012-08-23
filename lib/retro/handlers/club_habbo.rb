module Retro
  module Handlers

    class ClubHabbo < Handler

      def call
        [
            ClientMessage.new(:club_habbo, "club_habboYNEHHI"),
            ClientMessage.new("@W")
        ]
      end

    end

  end
end