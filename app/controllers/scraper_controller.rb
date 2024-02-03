class ScraperController < ApplicationController
    include ScraperHelper
    def index
        Scraper::ZalandoScraper.new("https://www.zalando.no/sneakers/?q=air+jordan+1+mid")
        


        render json:{status:"200 success"}
    end
end
