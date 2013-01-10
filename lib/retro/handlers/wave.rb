module Retro
  module Handlers

    class Wave < Handler

      def call
        Client::DurationMessage.new(wave_packet_enum) unless user.states.wave?
      end

      def wave_packet_enum
        Enumerator.new do |y|
          user.states.wave
          y << Client::MessageFactory.room_movement(user)
          EM::Timer.new(2) do
            user.states.wave!
            y << Client::MessageFactory.room_movement(user)
          end
        end
      end

    end

  end
end