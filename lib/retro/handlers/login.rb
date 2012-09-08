module Retro
  module Handlers

    class Login < Handler

      def call
        username = @data.pop_b64!
        password = @data.pop_b64!
        user = get_authenticated_user(username, password)
        if user
          @session.user = user
          [
              ClientMessage.new(:rights, "fuse_login"),
              ClientMessage.new(:login_ok),
          ]
        else
          ClientMessage.new("@c", "FUCK YOU!!!")
        end
      end

      def get_authenticated_user(username, password)
        user_record = DB[:users].first(name: username, password: password)
        User.new user_record if user_record
      end

    end

  end
end