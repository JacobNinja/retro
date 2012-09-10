module Retro

  class CatalogPage
    extend Attrs

    attr :id, :name, :visible_name, :order, :layout, :image_title, :side_image, :description, :label, :additional, :staff_only

    def initialize(opts={})
      @opts = opts
    end

    def items
      CatalogItem.by_page(self.id)
    end

    def self.all
      DB[:catalog_pages].all.map {|data| new(data) }
    end

    def self.find_by_name(name)
      data = DB[:catalog_pages].first(:name => name)
      if data
        catalog_page = new(data)
        if block_given?
          yield catalog_page
        else
          catalog_page
        end
      end
    end

  end

end