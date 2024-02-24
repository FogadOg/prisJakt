module ScraperComponent
    class ProcessProduct
        def initialize(link, image, name, price, logo, category)
            @link=link
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
                startProduct = Product.new(
                    name: @name,
                    image: @image,
                    categories: [@category]
                )
                startProduct.save
                startProduct.saveProductSource(
                    @price,
                    @logo,
                    @link
                )
            end
            loopOverProductModel()
            
        end

        def loopOverProductModel()
            Product.all.each do |product|

                prodcutVector = product.searchVector(@name)
                similarity = prodcutVector.cosineSimilarity(@tfIdfVector)
                
                if similarity > 2
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
                            categories: [@category]
                        )
                        newProduct.save
                        
                        newProduct.saveProductSource(
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