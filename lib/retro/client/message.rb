module Retro
  module Client

    class Message

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
          when Integer then Encoding::B64.encode(@header)
          when Symbol then
            header_int = Handlers::CLIENT_HEADERS[@header]
            Encoding::B64.encode(header_int)
          when String then @header
          else nil
        end

      end

      def body
        @body.join
      end

      def data
        packet = header + body
        #"@#{Encoding::Base64.encode(packet.length)}#{packet}#{1.chr}"
        "#{packet}#{1.chr}"
      end

      def packets
        [self]
      end

    end

  end
end