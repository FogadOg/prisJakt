class ScraperController < ApplicationController
    include ScraperHelper
    def index
        searchTerms=[
            "air jordan 1 mid"
        ]
        searchTerms.each do |searchTerm|
            ScraperComponent::Scraper::ZalandoScraper.new("https://www.zalando.no/herre/?q=",searchTerm)
            ScraperComponent::Scraper::ZalandoScraper.new("https://www.zalando.no/dame/?q=",searchTerm)

        end
        


        render json:{status:"200 success"}
    end
end
