module Scraper
    class ClusterData
        def initialize(image, name, price, logo, category)
            @image=image
            @name=name
            @price=price
            @logo=logo
            @category=category

            index()

        end
        
        def index()
            
            scrapeVector=TextProcessing::TfIdfVector.new()
            scrapeVector=scrapeVector.vectorForSearch(@name, @name)

            if Product.count.zero?
                ScrapeData.new(@image, @name, @category).save
            end
            loopOverProductModel(scrapeVector)
            
        end

        def loopOverProductModel(scrapeVector)
            Product.all.each do |product|
                
                prodcutVector=TextProcessing::TfIdfVector.new()
                prodcutVector=prodcutVector.vectorForSearch(product.name, @name)

                similarity=prodcutVector.cosineSimilarity(scrapeVector)

                if similarity>1.5
                    saveAddProductSource(product.id, @name, @price, @logo)
               
                else
                    if !isProductInDataBase(@image.value)
                        ScrapeData.new(@image, @name, @category).save
                        saveAddProductSource(product.id, @name, @price, @logo)
                    
                    end
                end

            end
        end


        def isProductInDataBase(image)
            return Product.exists?(image: image)
        end

        def saveAddProductSource(productId, name, price, logo)
            SourceOfProduct.new(
                productId:productId, 
                name:name, 
                price:price,
                image:logo
            ).save

        end
        

    end
end