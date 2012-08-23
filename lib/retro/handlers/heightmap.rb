module Retro
  module Handlers

    class Heightmap < Handler

      def call
        heightmap = 'xxxxxxxxxxxx|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxx00000000|xxxxxxxxxxxx|xxxxxxxxxxxx'.gsub("|", 13.chr)
        ClientMessage.new("@_", heightmap)
      end

    end

  end
end