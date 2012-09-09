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
              Client::Message.new(:rights, "fuse_login"),
              Client::Message.new(:login_ok),
          ]
        else
          Client::Message.new("@c", "FUCK YOU!!!")
        end
      end

      def get_authenticated_user(username, password)
        user_record = DB[:users].first(name: username, password: password)
        User.new user_record if user_record
      end

    end

  end
end