require 'nokogiri'
require 'open-uri'

module ScraperComponent
    class ScraperUtil
        def initialize(htmlElement)
            @element=htmlElement

        end

        def getLogo(cssSelector)
            return @element.at_css(cssSelector).attr("href")
        end


        def getProducts(productSelector)
            products=@element.css(
                productSelector
                )
            return ScraperUtil.new(products)
        end
        
        def processText(text)
            textPreprocess=TextProcessing::TextProcess.new(text)
            return textPreprocess.process
        end

        def save(linkSelector, imageSelector, nameSelector, priceSelector, logo, category)

            @element.each do |scrapeProduct|
                link=scrapeProduct.css(linkSelector).attr("href")
                image=scrapeProduct.css(imageSelector).attr("src")
                name=scrapeProduct.css(nameSelector).text
                price=scrapeProduct.css(priceSelector).text
                
                ProcessProduct.new(image, name, price, logo, category)

                
            end

        end

    end
end
