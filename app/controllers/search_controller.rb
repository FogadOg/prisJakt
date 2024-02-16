class SearchController < ApplicationController
    def search
      @query = params[:query]
      if @query === ""
        redirect_to root_path
      else
        queryVector = TextProcessing::TfIdfVector.new().vectorForSearch(@query, @query)
        @relatedProducts = getRelatedProducts(queryVector)

      end
    end
  
    private
  
    def getRelatedProducts(queryVector)
      relatedProducts = []
      Product.all.each do |product|
        productVector = TextProcessing::TfIdfVector.new().vectorForSearch(product.name, @query)
        if productVector.cosineSimilarity(queryVector) > 0.01
          relatedProducts.append(product)
        end
      end
      return relatedProducts
    end
  end
  