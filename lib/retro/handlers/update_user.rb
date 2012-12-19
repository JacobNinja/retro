module Retro
  module Handlers

    class UpdateUser < Handler

      def call
        user_update_hash = {}
        until data.rest.empty?
          type = data.pop_b64
          case type
            when 4
              user_update_hash[:figure] = data.pop_b64!
            when 5
              user_update_hash[:sex] = data.pop_b64!
            when 6
              user_update_hash[:mission] = data.pop_b64!
          end
        end
        UserManager.update(user.id, user_update_hash)
        Client::MessageFactory.user_details(user.update(user_update_hash))
      end

    end

  end
end