class HomeController < ApplicationController

    def index
        @products=Product.all
        render "home"
    end

    def show
        @product=Product.find(params[:id])

    end

end
