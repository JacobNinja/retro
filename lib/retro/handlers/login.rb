module Retro
  module Handlers

    class Login < Handler

      def call
        username = @data.pop_b64!
        password = @data.pop_b64!
        user = User.authenticate(username, password)
        if user
          @session.user = user
          [
              Client::Message.new(:rights, "fuse_login"),
              Client::Message.new(:login_ok),
          ]
        else
          Client::Message.new("@c", "FUCK YOU!!!")
        end
      end

    end

  end
end