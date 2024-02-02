require 'nokogiri'
require 'open-uri'

module ScraperHelper
    def findElements(url)
        htmlContent = URI.open(url, 'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36')
        
        doc = Nokogiri::HTML(htmlContent)

        elementClass = 'div._5qdMrS.w8MdNG.cYylcv.BaerYO._75qWlu.iOzucJ.JT3_zV._Qe9k6'

        elements=doc.css(elementClass)
        return elements 

    end

    def scrape(url)
        puts findElements(url)
    end
end
