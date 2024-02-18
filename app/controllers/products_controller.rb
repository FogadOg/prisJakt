require_relative 'textProcessing/tfIdf'
# ? Wtf er tfIDf?
class ProductsController < ApplicationController
    def index
        @products=Product.all
    end

    def show
        productId=params[:id]
        @product=Product.find(productId)
        @price_records=PriceRecord.where(productId: productId).pluck(:date, :price)
        @price_records = PriceRecord.where(productId: productId).map do |record|
            [ record[:date].strftime("%Y-%m-%d"), record[:price].sub("\u00A0", "")]
        end


        @productSource=SourceOfProduct.where(productId:productId)

    end


end
