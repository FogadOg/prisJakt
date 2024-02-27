require_relative '../services/zalando_scraper'

class ScraperController < ApplicationController
    include ScraperHelper
    def index
        ScrapeZalandoService.new.call
        render json:{status:"200 success"}
    end
end
