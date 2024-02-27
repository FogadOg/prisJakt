class Product < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :image
    has_many :price_records, dependent: :destroy
    has_many :source_of_products, dependent: :destroy

    def searchVector(otherTerm)

        tfIdfVector=TextProcessing::TfIdfVector.new()
        tfIdfVector=tfIdfVector.vectorForSearch(name, otherTerm)

        return tfIdfVector
    end

    def saveProductSource(price, image, link)
        priceNumerical, currency = extractPriceAndCurrancy(price)
        SourceOfProduct.new(
            product_id: id, 
            name: name, 
            price: priceNumerical, 
            image: image, 
            link: link,
            currency: currency
        ).save

    end

    def extractPriceAndCurrancy(string)
        number_pattern = /\d+/
        currency_pattern = /[a-zA-Z]+/

        numbers = string.scan(number_pattern)
        currency = string.scan(currency_pattern).first
      
        number = numbers.join('').to_i
      
        return (number / 100).to_i, currency
    end

    def newPriceRecord(price, batch_id, currency=nil)
        if currency==nil
            processPrice(price, batch_id)        
        else
            PriceRecord.new(
                product_id:id, 
                price: price, 
                date:Date.today, 
                currency: currency,
                batch: batch_id
            ).save   

        end
    end

    def processPrice(price, batch_id)
        priceNumerical, currency = extractPriceAndCurrancy(price)
            
        PriceRecord.new(
            product_id:id, 
            price: priceNumerical, 
            date:Date.today, 
            currency: currency,
            batch: batch_id
        ).save
    end

    def priceChange
        priceRecords=price_records
        
        if priceRecords == []
            return 0
        end

        oldestRecord = priceRecords.order(date: :asc).first
        oldPrice=oldestRecord.price

        regex = /(?:\D*)(\d{1,3}(?:[., ]\d{3})*(?:,\d+)?)(?:\D*)/

        sumPrice=0

        priceRecords.each do |record|

            sumPrice+=record.price
        end

        avaragePrice=sumPrice/priceRecords.count
        priceDifferance=(oldPrice-avaragePrice).to_f

        differanceInPrecentage=(priceDifferance/avaragePrice)*100

        return differanceInPrecentage.to_i

    end

end
