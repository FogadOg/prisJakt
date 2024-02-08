class SearchController < ApplicationController

    def search
        @query=params[:query]
        

        processedQuery=processText(@query)
        
        queryTfIdf=Search::TfIdf.new(@query)
        queryVector=Search::TfIdfVector.new()
        queryVector.generateTfIdfVector(queryTfIdf, @query)
        @relatedProducts=getRelatedProducts(queryVector)
        
    end

    def getRelatedProducts(queryVector)
        relatedProducts=[]

        Product.all.each do |product|
            processedName=processText(product.name)
            
            productTfIdf=Search::TfIdf.new(processedName)
            prodcutVector=Search::TfIdfVector.new()
            prodcutVector.generateTfIdfVector(productTfIdf, @query)

            if prodcutVector.cosineSimilarity(queryVector)>0.08
                relatedProducts.append(product)
            end
        end   

        return relatedProducts

    end

    def processText(text)
        textPreprocess=Search::TextProcess.new(text)
        return textPreprocess.process
    end

end
