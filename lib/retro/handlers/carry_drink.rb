module Retro
  module Handlers

    class CarryDrink < Handler

      def call
        drink = data.rest
        Client::DurationMessage.new(user_drink_enum(drink))
      end

      def user_drink_enum(drink)
        Enumerator.new do |y|
          user.states.drink(drink)
          y << Client::MessageFactory.room_movement(user)
          EM::Timer.new(120) do
            user.states.drink!
            y << Client::MessageFactory.room_movement(user)
          end
        end
      end

    end

  end
end