module Retro

  class ClientMessage

    def initialize(header, body=nil)
      @header = header
      @body = Array(body)
    end

    def add(data)
      @body << data
      self
    end

    def header
      case @header
        when Integer then Encoding::Base64.encode(@header)
        when Symbol then
          header_int = Handlers::CLIENT_HEADERS[@header]
          Encoding::Base64.encode(header_int)
        when String then @header
        else nil
      end

    end

    def body
      @body.join
    end

    def packet
      packet = header + body
      #"@#{Encoding::Base64.encode(packet.length)}#{packet}#{1.chr}"
      "#{packet}#{1.chr}"
    end

  end

end