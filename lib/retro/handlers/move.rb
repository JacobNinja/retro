module Retro
  module Handlers

    class Move < Handler

      def call
        x = data.pop_b64
        y = data.pop_b64
        user_movements = user_manager.move(x, y)
        return nil unless user_movements

        Client::DurationMessage.new(user_movement_enum(user_movements))
      end

      def user_movement_enum(user_movements)
        Enumerator.new do |y|
          first_movement = user_movements.next
          y << Client::MessageFactory.room_movement(first_movement)
          timer = EM::PeriodicTimer.new(0.5) do
            begin
              next_movement = user_movements.next
              packet = Client::MessageFactory.room_movement(next_movement)
              y << packet
            rescue StopIteration
              timer.cancel
            end
          end
        end
      end

    end

  end
end