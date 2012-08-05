module Retro

  class User

    def decrypt(data)
      if @encryption
        @encryption.decipher(data)
      else
        data
      end
    end

    def greeting
      ClientMessage.new(:greeting)
    end

    def initialize_encryption(public_key)
      @encryption = Retro::Encryption::RC4.new(public_key)
    end

  end

end