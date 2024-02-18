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
        SourceOfProduct.new(
            productId: id, 
            name: name, 
            price: price, 
            image: image, 
            link: link
        ).save

        newPriceRecord(price)

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
