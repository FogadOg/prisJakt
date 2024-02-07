require_relative 'search/tfidf'

class HomeController < ApplicationController

    def index
        @products=Product.all
        render "home"
    end

    def show
        @product=Product.find(params[:id])

    end

    def search
        @query=params[:query]
        @relatedProducts=[]
        

        textPreprocess=Search::TextProcess.new(@query)
        processedQuery=textPreprocess.process
        
        queryTfIdf=Search::TfIdf.new(@query)
        queryVector=Search::TfIdfVector.new()
        queryVector.generateTfIdfVector(queryTfIdf, @query)

        Product.all.each do |product|
            textPreprocess=Search::TextProcess.new(product.name)
            processedName=textPreprocess.process
            
            productTfIdf=Search::TfIdf.new(processedName)
            prodcutVector=Search::TfIdfVector.new()
            prodcutVector.generateTfIdfVector(productTfIdf, @query)

            if prodcutVector.cosineSimilarity(queryVector)>0.08
                @relatedProducts.append(product)
            end
        end

        
        
    end


end
