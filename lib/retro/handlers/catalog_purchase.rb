module Retro
  module Handlers

    class CatalogPurchase < Handler

      def call
        _, _, _, purchase_code, _, gift = data.rest.split("\r")
        catalog_item = CatalogItem.find_by_purchase_code(purchase_code)
        if catalog_item
          Item.create(user, catalog_item.furni_definition)
          [
              Client::Message.new(67), # Purchase accepted
              #Client::Message.new("@F") # New credit amount
          ]
        end
        #Client::Message.new(68) # Not enough credits
      end

    end

  end
end