module Retro

  class User

    def react(header, body)
      if respond_to? header
        send(header, body)
      else
        p "Need a header definition for #{header}"
        nil
      end
    end

    def decrypt(data)
      if @encryption
        @encryption.decipher(data)
      else
        data
      end
    end

    def greeting
      [:greeting, ""]
    end

    # @E
    def check_version(data)
      public_key = "55wfe030o2b17933arq9512j5u111105ckp230c81rp3m61ew9er3y0d523"
      @encryption = Retro::Encryption::RC4.new(public_key)
      [[:public_key, public_key], [:encryption_begin, ""]]
    end

    def shockwave_id(data)

    end

    def login(data)
      [[:rights, "fuse_login"], [:login_ok, ""]]
    end

    def user_details(data)
      [[:name, "@Ename=User\rfigure=1150120723280013050122525\rsex=M\rcustomData=Billy Jean!\rph_tickets=0\rphoto_film=0\rph_figure=\rdirectMail=0\r"]]
    end

    def credits(data)
      [[:credits, "0.0"]]
    end

    def club_habbo(data)
      [[:club_habbo, "club_habboYNEHHI"], ["@W", ""]]
    end

  end

end