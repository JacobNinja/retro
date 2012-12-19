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
      @furni_definition ||= FurniDefinitionManager.find(@furni_definition_id)
    end

    def name
      "toDO"
    end

    def description
      "TODO"
    end

  end

end