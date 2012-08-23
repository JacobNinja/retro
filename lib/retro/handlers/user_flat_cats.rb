module Retro
  module Handlers

    class UserFlatCats < Handler

      def call
        ClientMessage.new("C]", private_category_response)
      end

      private

      def private_category_response
        [].tap do |list|
          list << Encoding::VL64.encode(1) # category count
          list << Encoding::VL64.encode(1234) # category id
          list << "Category Name"
          list << 2.chr
        end.join
      end

    end
  end
end