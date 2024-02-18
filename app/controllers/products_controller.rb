require_relative 'textProcessing/tfIdf'
# ? Wtf er tfIDf?
class ProductsController < ApplicationController
    def index
        @products=Product.all
    end

    def show
        product_id=params[:id]
        @product=Product.find(product_id)
        @price_records = @product.price_records.map do |record|
            [ record[:date].strftime("%Y-%m-%d"), record[:price].sub("\u00A0", "")]
        end


        @productSource=SourceOfProduct.where(productId:product_id)

    end


end
