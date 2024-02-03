require 'nokogiri'
require 'open-uri'

module Scraper
    class ZalandoScraper < Scraper

        
        def scrape(products, priceSelector, linkSelector, nameSelector, imageSelector)

            products.each do |product|
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
