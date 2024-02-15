module ScraperComponent
    class ProcessProduct
        def initialize(image, name, price, logo, category)
            @image=image
            @name=name
            @price=price
            @logo=logo
            @category=category

            
            @tfIdfVector=TextProcessing::TfIdfVector.new().vectorForSearch(@name, @name)

            startProcess()

        end
        
        def startProcess()
            if Product.count.zero?
                ProductData.new(@image, @name, @category).save
            end
            loopOverProductModel()
            
        end

        def loopOverProductModel()
            Product.all.each do |product|

                prodcutVector = product.searchVector(@name)
                similarity = prodcutVector.cosineSimilarity(@tfIdfVector)

                if similarity > 1.5
                    saveProductSource(product.id)
                else
                    if !isProductInDataBase(@image.value)
                        addProductAndSource(product.id)
                    end
                end

            end
        end
        
        def isProductInDataBase(image)
            return Product.exists?(image: image)
        end

        def addProductAndSource(productId)
            ProductData.new(@image, @name, @category).save
            saveProductSource(productId)
        end

        def saveProductSource(productId)
            SourceOfProduct.new(
                productId:productId, 
                name:@name, 
                price:@price,
                image:@logo
            ).save
            PriceRecord.new(productId:productId,price:@price, date: Date.today).save

        end
        

    end
end