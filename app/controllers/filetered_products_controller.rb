class FileteredProductsController < ApplicationController

    def show
        @products = Product.all

        if params[:category] && params[:category] != ""
            category params[:category]
        end

        if params[:search] && params[:search] != ""
            search params[:search]
        end

    end
    private
    # Handling multiple queries
    # Handling non exiting category
    def category(category_query)
        puts category_query
        @products = @products.where(category: category_query)
    end
    def search(search_query)
        query_vector = TextProcessing::TfIdfVector.new.vectorForSearch(search_query, search_query)
        related_products = []
        @products.each do |product|
            product_vector = TextProcessing::TfIdfVector.new.vectorForSearch(product.name, search_query)
            if product_vector.cosineSimilarity(query_vector) > 0.01
                related_products.append(product)
            end
        end
        @products = related_products

    end

end
