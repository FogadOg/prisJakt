module Scraper
    class ScrapeData
        attr_reader :link, :image, :name, :price

        def initialize(link, image, name, price)
            @link=link
            @image=image
            @name=name
            @price=price
        end
        def to_s
            @name.to_s
        end

        def getAttribute(attribute)
            case attribute
            when :link
              return @link
            when :image
              return @image
            when :name
              return @name
            when :price
              return @price
            else
              raise ArgumentError, "Invalid attribute: #{attribute}"
            end
          end


    end
end