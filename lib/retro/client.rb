require 'socket'

module Retro

  class Client

    def simulate
      login
      post_login
    end

    def post_login
      send_data "@G"
      stuff = socket.recv 250
      p stuff
    end

    def login
      handshake = socket.recv 250
      p handshake
      send_data "@EFQ"
      public_key = socket.recv 250
      p public_key
      @encryption = Encryption::RC4.new("55wfe030o2b17933arq9512j5u111105ckp230c81rp3m61ew9er3y0d523")
      send_data "@F@P6CE0541185445713"
      send_data "@D@DUser@Gtest123"
      alert = socket.recv 250
      p "alert: #{alert}"
      rights = socket.recv 250
      p rights
      login_ok = socket.recv 250
      p login_ok
    end

    def socket
      @socket ||= TCPSocket.open('localhost', 1234)
    end

    def send_data(data)
      response = Encoding::B64.encode(data.length) + data
      p "Outgoing => response: #{response}"
      socket.write encrypt("@#{response}")
    end

    def encrypt(data)
      if @encryption
        @encryption.encipher(data)
      else
        data
      end
    end

  end

end

if $0 == __FILE__
  Retro::Client.new.simulate
end
