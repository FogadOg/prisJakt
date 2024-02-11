class CategoryPageController < ApplicationController

    def category
        @products=Product.where(category:params[:query])
    end
end
