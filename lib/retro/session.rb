module Retro

  class Session

    attr_accessor :user

    def initialize(connection, user=nil)
      @connection = connection
      @user = user
    end

    def decrypt(data)
      if @encryption
        @encryption.decipher(data)
      else
        data
      end
    end

    def initialize_encryption(public_key)
      @encryption = Retro::Encryption::RC4.new(public_key)
    end

  end

end