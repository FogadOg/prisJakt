require 'nokogiri'
require 'open-uri'

module Scraper
    class ScraperUtil
        def initialize(htmlElement)
            @element=htmlElement

        end


        def getProducts(productSelector)
            products=@element.css(
                productSelector
                )
            return ScraperUtil.new(products)
        end

        def save(linkSelector, imageSelector, nameSelector, priceSelector)

            @element.each do |product|
                link=product.css(linkSelector).attr("href")
                name=product.css(nameSelector).text
                image=product.css(imageSelector).attr("src")
                price=(product.xpath(priceSelector).first).text

                                      
                product=ScrapeData.new(link, image, name, price).save
            end

        end

    end
end
