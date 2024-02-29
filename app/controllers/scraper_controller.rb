require_relative '../services/scrapers'

class ScraperController < ApplicationController
    include ScraperHelper
    def index

        ScrapersService.new.call

        render json:{status:"200 success"}
    end
end
