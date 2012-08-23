module Retro
  module Handlers

    class Login < Handler

      def call
        username_length = Encoding::Base64.decode(@data[0..1])
        username = data[2, username_length]
        @session.user = User.new(name: username, figure: "1150120723280013050122525", sex: "M", custom_data: "mission", ph_tickets: 0, photo_film: 0, direct_mail: 0)
        [
            ClientMessage.new(:rights, "fuse_login"),
            ClientMessage.new(:login_ok),
        ]
      end

    end

  end
end