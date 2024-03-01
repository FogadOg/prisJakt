require_relative '../services/scrapers'

class ScraperController < ApplicationController
    include ScraperHelper
    def index
        if params[:search_params] and params[:search_params].split(",") != []
            ScrapersService.new.call(search_terms: params[:search_params].split(","))
            render json:{status:"200 success", searching_params: params[:search_params].split(",")}
        else
            ScrapersService.new.call
            render json:{status:"200 success", searching_params: "air jordan 1"}
        end
        # ScrapersService.new.call
    end
end
