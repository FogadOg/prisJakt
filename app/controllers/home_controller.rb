require_relative 'textProcessing/tfIdf'

class HomeController < ApplicationController

    def index
        @products=Product.all
        render "home"
    end

    def show
        productId=params[:id]
        @product=Product.find(productId)
        @priceRecord=PriceRecord.where(productId: productId).pluck(:productId, :price, :date)

        @productSource=SourceOfProduct.where(productId:productId)

    end


end
