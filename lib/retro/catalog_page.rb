module Retro

  class CatalogPage
    extend Attrs

    attr :id, :name, :visible_name, :order, :layout, :image_title, :side_image, :description, :label, :additional, :staff_only

    def initialize(opts={})
      @opts = opts
    end

    def items
      CatalogItemManager.find_by_catalog_page(self)
    end

  end

end