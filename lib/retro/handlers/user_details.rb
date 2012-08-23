module Retro
  module Handlers

    class UserDetails < Handler

      def call
        user = @session.user
        packet = ["name=#{user.name}", "figure=#{user.figure}", "sex=#{user.sex}", "customData=#{user.custom_data}", "ph_tickets=#{user.ph_tickets}", "photo_film=#{user.photo_film}", "directMail=#{user.direct_mail}"]
        ClientMessage.new(:name, packet.join("\r") + "\r")
      end

    end

  end
end