require_relative 'textProcessing/tfIdf'
# ? Wtf er tfIDf?
class ProductsController < ApplicationController
    def index
        @products=Product.all
    end

    def show
        productId=params[:id]
        @product=Product.find(productId)
        @priceRecords=PriceRecord.where(productId: productId).pluck(:price, :date)

        @productSource=SourceOfProduct.where(productId:productId)

    end


end
