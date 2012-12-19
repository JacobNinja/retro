module Retro
  module Handlers

    class CatalogPageInfo < Handler

      def call
        _, page_name = data.rest.split("/")
        catalog_page = CatalogPageManager.find_by_name(page_name)
        return nil unless catalog_page
        response = page_response(catalog_page)
        catalog_page.items.each do |catalog_item|
          response.add item_response(catalog_item)
        end
        response
      end

      def page_response(catalog_page)
        response = Client::Message.new(127)
        response.add "i:#{catalog_page.name}#{13.chr}"
        response.add "n:#{catalog_page.visible_name}#{13.chr}"
        response.add "l:#{catalog_page.layout}#{13.chr}"
        response.add "g:#{catalog_page.image_title}#{13.chr}" unless catalog_page.image_title == ""
        response.add "e:#{catalog_page.side_image}#{13.chr}" unless catalog_page.side_image == ""
        response.add "h:#{catalog_page.description}#{13.chr}" unless catalog_page.description == ""
        response.add "h:#{catalog_page.label}#{13.chr}" unless catalog_page.label == ""
        response.add "#{catalog_page.additional.gsub("|", 13.chr)}#{13.chr}" unless catalog_page.additional == ""
      end

      def item_response(catalog_item)
        response = [
            "p:#{catalog_item.name}",
            9.chr,
            catalog_item.description,
            9.chr,
            catalog_item.cost,
            9.chr, 9.chr,
            catalog_item.hand_type.downcase,
            9.chr,
            catalog_item.sprite
        ]
        if catalog_item.wall_item?
          response << 20
          response << 9.chr
          response << 9.chr
          response << 9.chr
        else
          response << 9.chr
          response << 0
          response << 9.chr
          response << catalog_item.width
          response << ","
          response << catalog_item.length
          response << 9.chr
        end
        response << catalog_item.purchase_code
        response << 9.chr
        response << catalog_item.col unless catalog_item.wall_item?
        response << 13.chr
        response.join
      end

    end

  end
end