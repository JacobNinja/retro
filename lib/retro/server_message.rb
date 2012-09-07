module Retro

  class ServerMessage

    def initialize(data)
      @original_data = data
      @data = data.dup
    end

    def pop_b64
      encoded_length = @data.slice! 0, 2
      @data.slice! 0, Encoding::B64.decode(encoded_length)
    end

    def pop_vl64
      Encoding::VL64.decode @data.slice!(0, 1)
    end

    def rest
      @data
    end

  end

end