module ScraperComponent
    class ClusterData
        def initialize(image, name, price, logo, category)
            @image=image
            @name=name
            @price=price
            @logo=logo
            @category=category

            startClustering()

        end
        
        def startClustering()
            
            tfIdfVector=TextProcessing::TfIdfVector.new()
            tfIdfVector=tfIdfVector.vectorForSearch(@name, @name)

            if Product.count.zero?
                ProductData.new(@image, @name, @category).save
            end
            loopOverProductModel(tfIdfVector)
            
        end

        def loopOverProductModel(tfIdfVector)
            Product.all.each do |product|
                
                prodcutVector=TextProcessing::TfIdfVector.new()
                prodcutVector=prodcutVector.vectorForSearch(product.name, @name)

                similarity=prodcutVector.cosineSimilarity(tfIdfVector)

                addProduct(product.id, similarity)

            end
        end

        def addProduct(productId, similarity)
            if similarity>1.5
                saveProductSource(product.id)
           
            else
                if !isProductInDataBase(@image.value)
                    addProductAndSource(productId)
                end
            end
        end

        def addProductAndSource(productId)
            ProductData.new(@image, @name, @category).save
            saveProductSource(productId)
        end


        def isProductInDataBase(image)
            return Product.exists?(image: image)
        end

        def saveProductSource(productId)
            SourceOfProduct.new(
                productId:productId, 
                name:@name, 
                price:@price,
                image:@logo
            ).save

        end
        

    end
end