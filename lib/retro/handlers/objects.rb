module Retro
  module Handlers

    class Objects < Handler

      def call
        floor_objects = [1.to_s, "test", "0", "0", "0.00", "1"].join(20.chr) + 13.chr
        floor_furni = [1.to_s, 2.chr, "test", 2.chr, Encoding::VL64.encode(0), Encoding::VL64.encode(0), Encoding::VL64.encode(1), Encoding::VL64.encode(1), Encoding::VL64.encode(0), "0.00", 2.chr, "2", 2.chr, 2.chr, Encoding::VL64.encode(60), "furni_var", 2.chr].join
        floor_furni_response = Encoding::VL64.encode(1) + floor_furni
        [
            ClientMessage.new("@^", floor_objects),
            ClientMessage.new("@`", floor_furni_response)
        ]
      end

    end

  end
end