require_relative 'textProcessing/tfIdf'
# ? Wtf er tfIDf?
class ProductsController < ApplicationController
    def index
        @products=Product.all
    end

    def show
        product_id=params[:id]
        @product=Product.find(product_id)
        @price_records = PriceRecord.where(product_id: product_id)

        @productSource=@product.source_of_products

    end


end
