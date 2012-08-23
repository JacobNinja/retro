module Retro
  module Handlers

    class CheckVersion < Handler

      @header = 1

      def call
        public_key = "55wfe030o2b17933arq9512j5u111105ckp230c81rp3m61ew9er3y0d523"
        @user.initialize_encryption(public_key)
        response = ClientMessage.new(header)
        response.add public_key
      end

    end
  end
end