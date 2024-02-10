class SearchController < ApplicationController

    def search
        @query=params[:query]

        queryVector=TextProcessing::TfIdfVector.new().vectorForSearch(@query, @query)

        @relatedProducts=getRelatedProducts(queryVector)
        
    end

    def getRelatedProducts(queryVector)
        relatedProducts=[]

        Product.all.each do |product|
            
            prodcutVector=TextProcessing::TfIdfVector.new().vectorForSearch(product.name, @query)

            if prodcutVector.cosineSimilarity(queryVector)>0.01
                relatedProducts.append(product)
            end
        end   

        return relatedProducts

    end


end
