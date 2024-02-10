require_relative 'textProcessing/tfidf'

class HomeController < ApplicationController

    def index
        @products=Product.all
        render "home"
    end

    def show
        @product=Product.find(params[:id])
        @productSource=SourceOfProduct.where(productId:params[:id])

    end


end
