module Retro
  module Handlers

    class GStat < Handler

      def call
        [
            ClientMessage.new("@\\", get_user_entry_packet),
            ClientMessage.new("@j"), # rights
            ClientMessage.new("@o"), # admin rights ?
            ClientMessage.new("@b", "0 3,5,0.0,2,2/" + 13.chr)
        ]
      end

      private

      def get_user_entry_packet
        [].tap do |list|
          list << "i:0" + 13.chr
          list << "n:#{user.name}" + 13.chr
          list << "f:hr-681-31.hd-180-7.ch-240-84.lg-270-90.sh-908-66.ea-1404-74" + 13.chr
          list << "l:3 5 0" + 13.chr
          list << "s:#{user.sex}" + 13.chr
          list << "c:mission" + 13.chr
        end.join
      end

    end

  end
end