module Retro
  module Handlers

    class CatalogPurchase < Handler

      def call
        _, _, _, purchase_code, furni_var, gift = data.rest.split("\r")
        catalog_item = CatalogItemManager.find_by_purchase_code(purchase_code)
        if catalog_item
          ItemManager.create(user, catalog_item.furni_definition, furni_var: furni_var)
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