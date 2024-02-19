class Product < ApplicationRecord
    validates :name, presence: true
    validates :image, presence: true, allow_blank: false
    has_many :price_records, dependent: :destroy
    has_many :source_of_products, dependent: :destroy

    def searchVector(otherTerm)

        tfIdfVector=TextProcessing::TfIdfVector.new()
        tfIdfVector=tfIdfVector.vectorForSearch(name, otherTerm)

        return tfIdfVector
    end

    def saveProductSource(name, price, image, link)
        priceNumerical, currency = extractPriceAndCurrancy(price)
        SourceOfProduct.new(
            productId: id, 
            name: name, 
            price: priceNumerical, 
            image: image, 
            link: link,
            currency: currency
        ).save

        newPriceRecord(price)

    end

    def extractPriceAndCurrancy(string)
        number_pattern = /\d+/
        currency_pattern = /[a-zA-Z]+/

        numbers = string.scan(number_pattern)
        currency = string.scan(currency_pattern).first
      
        number = numbers.join('').to_i
      
        return (number / 100).to_i, currency
    end

    def newPriceRecord(price)
        PriceRecord.new(productId:id, price: price, date:Date.today).save
    end

    def extractDigits(string)
        pattern = /\d[\d\s,.]*\d|\d/
        matches = string.scan(pattern)
        extracted_digits = matches.join('').gsub(',', '.')
        extracted_digits.to_i

    end

    def priceChange
        priceRecords=price_records
        if priceRecords == []
            return 0
        end

        oldestRecord = priceRecords.order(date: :asc).first
        oldPrice=extractDigits(oldestRecord.price)

        regex = /(?:\D*)(\d{1,3}(?:[., ]\d{3})*(?:,\d+)?)(?:\D*)/

        sumPrice=0

        priceRecords.each do |record|

            sumPrice+=extractDigits(record.price)
        end

        avaragePrice=sumPrice/priceRecords.count
        priceDifferance=(oldPrice-avaragePrice).to_f

        differanceInPrecentage=(priceDifferance/avaragePrice)*100

        return differanceInPrecentage.to_i

    end

end
