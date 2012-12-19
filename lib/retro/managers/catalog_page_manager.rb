module Retro

  class CatalogPageManager

    extend Query

    def self.find_by_name(name)
      filter(name: name).first
    end

    private

    def self.repository
      Repository.catalog_pages
    end

  end
end