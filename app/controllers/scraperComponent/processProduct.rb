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
                
                if similarity > 1
                    product.saveProductSource(
                        @name,
                        @price,
                        @logo,
                        @link
                    )

                else
                    if !isProductInDataBase(@image.value)
                        _addTermsToIdfCount(@name)
                        newProduct = Product.new(
                            name: @name,
                            image: @image,
                            category: @category
                        )
                        newProduct.save
                        
                        newProduct.saveProductSource(
                            @name,
                            @price,
                            @logo,
                            @link
                        )
                    end
                end

            end
        end

        def _addTermsToIdfCount(sentance)
            textPreprocess=TextProcessing::TextProcess.new(sentance)
            processedText=textPreprocess.process
      
            splitSentance=processedText.split
            removedDuplicateWords=splitSentance.uniq
      
            jsonService=Service::TfIdfService.new("idfCount.json")
      
            removedDuplicateWords.each do |word|
              jsonService.incrementTerm(word)
            end
      
          end
        
        def isProductInDataBase(image)
            return Product.exists?(image: image)
        end        

    end
end