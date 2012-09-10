module Retro

  class ServerMessage

    def initialize(data)
      @original_data = data
      @data = data.dup
    end

    def pop_b64!
      @data.slice! 0, pop_b64
    end

    def pop_b64
      encoded_length = @data.slice! 0, 2
      Encoding::B64.decode(encoded_length)
    end

    def pop_vl64
      header_byte = @data.slice(0, 1).ord
      Encoding::VL64.decode @data.slice!(0, vl64_content_length(header_byte))
    end

    def vl64_content_length(byte)
      if byte < 80
        1
      elsif byte < 88
        2
      else
        3
      end
    end

    def rest
      @data
    end

  end

end