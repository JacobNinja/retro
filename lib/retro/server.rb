require 'eventmachine'

module Retro

  class Server

    module Reactor

      @@connections = {}

      def post_init
        user = Retro::User.new
        @@connections[self.object_id] = user
        send_response(user.greeting)
      end

      def receive_data(data)
        user = @@connections[self.object_id]
        decrypted_data = user.decrypt(data)
        parse_packet(decrypted_data) do |header, body|
          encoded_header = Encoding::Base64.encode(header)
          p "Incoming => header: [#{encoded_header}, #{header}], body: #{body}, decoded: #{decrypted_data}"
          handler = Handlers::SERVER_HEADERS[header] || Handlers.null(header)
          responses = handler.new(user, body).call
          Array(responses).each &method(:send_response)
        end
      end

      def send_response(response)
        if response
          p "Outgoing => header: #{response.header}, body: #{response.body}, encoded: #{response.packet}"
          send_data response.packet
        end
      end

      def parse_packet(data, &block)
        data_len = Encoding::Base64.decode(data[0..2])
        data_body = data[3, data_len]
        encoded_header = data_body[0..1]
        packet_len = (data_len + 3)
        body = data_body[2..-1]
        header_int = Encoding::Base64.decode(encoded_header)
        block.call(header_int, body)
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