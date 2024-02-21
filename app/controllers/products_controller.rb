require_relative 'textProcessing/tfIdf'
# ? Wtf er tfIDf?
class ProductsController < ApplicationController
    def index
        @products=Product.all
    end

    def show
        product_id=params[:id]
        @product=Product.find(product_id)
        # Have to have date and price for chart
        @price_records = @product.price_records.pluck(:date,:price)

        @product_source=@product.source_of_products

    end


end
