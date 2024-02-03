require 'nokogiri'
require 'open-uri'

module Scraper
    class Scraper
        def initialize(url)
            htmlContent = URI.open(url, 'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36')
            @doc = Nokogiri::HTML(htmlContent)
            @size=nil

        end

        def size
            return @size
        end



        def getProducts(productSelector)
            products=@doc.css(
                productSelector
                )
            @size=products.length
            return products
        end

    end
end
