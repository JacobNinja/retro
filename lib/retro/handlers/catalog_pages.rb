module Retro
  module Handlers

    class CatalogPages < Handler

      def call
        response = Client::Message.new("A~")
        CatalogPageManager.all.each do |catalog_page|
          response.add page_response(catalog_page)
        end
        response
      end

      def page_response(catalog_page)
        [
            catalog_page.name,
            9.chr,
            catalog_page.visible_name,
            13.chr
        ].join
      end

    end
  end
end