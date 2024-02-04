class HomeController < ApplicationController

    def index
        @products=Product.all
        render "home"
    end

end
