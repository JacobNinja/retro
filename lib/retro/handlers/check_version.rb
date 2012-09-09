module Retro
  module Handlers

    class CheckVersion < Handler

      @header = 1
      @body = "55wfe030o2b17933arq9512j5u111105ckp230c81rp3m61ew9er3y0d523"

      def call
        user.initialize_encryption(@body)
        super
      end

    end
  end
end