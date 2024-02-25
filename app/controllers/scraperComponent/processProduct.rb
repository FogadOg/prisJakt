module ScraperComponent
    class ProcessProduct
        def initialize(product, link, price, logo)
            @product=product

            @name=product.name
            @image=product.image

            @link=link
            @price=price
            @logo=logo
            
            @tfIdfVector=TextProcessing::TfIdfVector.new().vectorForSearch(@name, @name)

            startProcess()

        end
        
        def startProcess()
            if Product.count.zero?                
                addProductWithSource()
            end
            loopOverProductModel()
            
        end

        def loopOverProductModel()
            Product.all.each do |product|

                prodcutVector = product.searchVector(@name)

                
                if isVectorSimilar(prodcutVector, 2)
                    @product.saveProductSource(
                        @name,
                        @price,
                        @logo,
                        @link
                    )
                    return

                elsif !isProductInDataBase(@name)
                    _addTermsToIdfCount(@name)
                    addProductWithSource()
                    return
                end

                addPriceRecordForToday(product)
            end
        end


        def isVectorSimilar(vector, threshold)
            similarity = vector.cosineSimilarity(@tfIdfVector)
            
            if similarity > threshold
                return true
            end
            return false

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
        
        def isProductInDataBase(name)
            return Product.exists?(name: name)
        end     
        
        def addPriceRecordForToday(product)
            if PriceRecord.where(product_id: product.id).where.not(date: Date.today).exists?
                product.newPriceRecord(@price)
            end              
        end

        def addProductWithSource()
            product = Product.new(
                name: @name,
                image: @image,
            )
            product.save
            product.saveProductSource(
                @price,
                @logo,
                @link
            )
    
        end
    end

end