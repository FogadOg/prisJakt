module ScraperComponent
    class ProcessProducts
        def initialize(element, logo)
            @element=element
            @logo=logo

            @firstBatch=true

        end

        def save(linkSelector, imageSelector, nameSelector, priceSelector, logo)

            @element.each do |scrapeProduct|
                link=scrapeProduct.css(linkSelector).attr("href")
                image=scrapeProduct.css(imageSelector).attr("src")
                name=scrapeProduct.css(nameSelector).text
                price=scrapeProduct.css(priceSelector).text
                
                if Product.count.zero?                
                    addProductWithSource(name, image, price, link)
                end
                startProcess(link, image, name, price)
                @firstBatch=false
  
            end

        end

        def startProcess(link, image, name, price)
            newProductVector=TextProcessing::TfIdfVector.new().vectorForSearch(name, name)

            Product.all.each do |product|

                prodcutVector = product.searchVector(name)

                
                if isVectorSimilar(prodcutVector, newProductVector, 2)
                    product.saveProductSource(
                        price,
                        @logo,
                        link
                    )

                    return

                elsif !isProductInDataBase(name)
                    _addTermsToIdfCount(name)
                    addProductWithSource(name, image, price, link)

                    return
                elsif @firstBatch==true
                    product.newPriceRecord(price)
                    
                end

            end
        end


        def isVectorSimilar(vector1, vector2, threshold)
            similarity = vector1.cosineSimilarity(vector2)
            
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

        def addProductWithSource(name, image, price, link)
            product = Product.new(
                name: name,
                image: image,
            )
            product.save
            product.saveProductSource(
                price,
                @logo,
                link
            )
    
        end
    end

end