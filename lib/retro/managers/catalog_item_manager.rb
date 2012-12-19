module Retro

  class CatalogItemManager

    extend Query

    def self.find_by_catalog_page(catalog_page)
      filter(catalog_page_id: catalog_page.id)
    end

    def self.find_by_purchase_code(purchase_code)
      filter(purchase_code: purchase_code).first
    end

    private

    def self.repository
      Repository.catalog_items
    end

  end

end