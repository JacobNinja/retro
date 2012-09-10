module Retro
  module Handlers

    class UserDetails < Handler

      def call
        Client::MessageFactory.user_details(user)
      end

    end

  end
end