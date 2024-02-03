require 'nokogiri'
require 'open-uri'

module Scraper
    class ScraperUtil
        def initialize(htmlElement)
            @element=htmlElement

        end

        def size
            return @size
        end

        def getProducts(productSelector)
            products=@element.css(
                productSelector
                )
            @size=products.length
            return ScraperUtil.new(products)
        end

        def save(priceSelector, linkSelector, nameSelector, imageSelector)

            @element.each do |product|
                price=product.xpath(priceSelector).first
                link=product.css(linkSelector)
                name=product.css(nameSelector)
                image=product.css(imageSelector)

                                      
                product=ScrapeData.new(link.attr("href"), image.attr("src"), name.text, price.text)
                puts product
            end

        end

    end
end
