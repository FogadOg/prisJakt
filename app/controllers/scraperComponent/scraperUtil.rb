require 'nokogiri'
require 'open-uri'

module ScraperComponent
    class ScraperUtil
        def initialize(htmlElement)
            @element=htmlElement

        end
        def element
            return @element
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

    end
end
