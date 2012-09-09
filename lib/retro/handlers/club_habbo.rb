module Retro
  module Handlers

    class ClubHabbo < Handler

      def call
        [
            Client::Message.new(:club_habbo, "club_habboYNEHHI"),
            Client::Message.new("@W")
        ]
      end

    end

  end
end