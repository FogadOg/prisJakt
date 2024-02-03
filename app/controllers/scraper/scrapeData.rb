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


    end



end