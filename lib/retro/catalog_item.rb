module Retro

  class CatalogItem
    extend Attrs
    extend Forwardable

    attr :cost, :purchase_code

    delegate [:hand_type, :sprite, :width, :length, :col, :height, :flags, :furni_var, :wall_item?] => :furni_definition

    def initialize(opts={})
      @opts = opts
      @furni_definition_id = opts[:furni_definition_id]
      @catalog_page_id = opts[:catalog_page_id]
    end

    def furni_definition
      @furni_definition ||= FurniDefinition.find_by_id(@furni_definition_id)
    end

    def name
      "toDO"
    end

    def description
      "TODO"
    end

    def self.find_by_purchase_code(purchase_code)
      data = DB[:catalog_items].first(purchase_code: purchase_code)
      new(data) if data
    end

    def self.by_page(page_id)
      DB[:catalog_items].filter(catalog_page_id: page_id).map {|data| new(data) }
    end

  end

end