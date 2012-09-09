module Retro
  module Client

    class DurationMessage

      def initialize(packet_enum)
        @packet_enum = packet_enum
      end

      def packets
        @packet_enum
      end

    end


  end
end