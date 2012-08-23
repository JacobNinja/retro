module Retro
  module Handlers

    class LookTo < Handler

      def call
        ClientMessage.new("@b", "0 3,5,0.0,2,2/" + 13.chr)
      end

    end

  end
end