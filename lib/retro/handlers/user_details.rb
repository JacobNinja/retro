module Retro
  module Handlers

    class UserDetails < Handler

      def call
        packet = {
            "name" => user.name,
            "figure" => user.figure,
            "sex" => user.sex,
            "customData" => user.mission,
            "ph_tickets" => user.ph_tickets,
            "photo_film" => user.photo_film,
            "directMail" => user.direct_mail
        }
        Client::Message.new(:name, packet.map {|(k, v)| "#{k}=#{v}"}.join("\r") + "\r")
      end

    end

  end
end