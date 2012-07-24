require 'eventmachine'

module Retro

  class Server

    module Reactor

      @@connections = {}

      def post_init
        user = Retro::User.new
        @@connections[self.object_id] = user
        send_response(*user.greeting)
      end

      def receive_data(data)
        user = @@connections[self.object_id]
        decrypted_data = user.decrypt(data)
        parse_packet(decrypted_data) do |header, body|
          p "Incoming => header: #{header}, body: #{body}, decoded: #{decrypted_data}"
          responses = user.react(header, body)
          Array(responses).each do |(response_header, response_body)|
            send_response(response_header, response_body)
          end
        end
      end

      def send_response(header, body)
        response = encode(header, body)
        p "Outgoing => header: #{header}, body: #{body}, encoded: #{response}"
        send_data "#{response}#{1.chr}" if response
      end

      def encode(header, body)
        encoded_header = encode_header(header)
        if encoded_header
          full_body = encoded_header + body
          #Encoding::Base64.encode(full_body.length) + full_body
        end
      end

      def encode_header(header)
        case header
          when String then header
          when Symbol then
            begin
               header_int = CLIENT_HEADERS[header]
               Encoding::Base64.encode(header_int)
            end
          when Integer then Encoding::Base64.encode(header)
          else nil
        end
      end

      def parse_packet(data, &block)
        data_len = Encoding::Base64.decode(data[0..2])
        data_body = data[3, data_len]
        encoded_header = data_body[0..1]
        packet_len = (data_len + 3)
        body = data_body[2..-1]
        header_int = Encoding::Base64.decode(encoded_header)
        header = Retro::SERVER_HEADERS[header_int]
        if header
          block.call(header, body)
        else
          p "No mapping for header: #{encoded_header}, #{header_int}"
        end

        remaining_data = data[packet_len..-1]
        parse_packet(remaining_data, &block) unless remaining_data.empty?
      end

    end

    DEFAULT_PORT = 1234

    def self.run!(port=DEFAULT_PORT)
      EventMachine::run do
        EventMachine::start_server 'localhost', port, Reactor
      end
    end

  end

end