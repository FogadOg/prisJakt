require_relative '../services/scrapers'

class ScraperController < ApplicationController
    include ScraperHelper
    def index
        # separating search_terms by ","
        search_terms = params[:search_terms]&.split(",")

        # Defaults to air jordan 1
        if not search_terms.present? or search_terms.empty?
          search_terms = ["air jordan 1"]
        end

        # TODO: Get amount of products and pricerecords made?
        ScrapersService.new.call(search_terms: search_terms)
        render json:{status:"200 success", searching_terms: search_terms}
    end
end
