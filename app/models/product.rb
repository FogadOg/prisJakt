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
        # Define a regular expression pattern to match the currency symbol and the price
        pattern = /([^\d]+)\s*([\d, ]+)/

        # Use match method to find the pattern in the string
        match = string.match(pattern)

        if match
            currency = match[1].strip
            price = match[2].gsub(/[ ,]/, '').gsub(',', '.') # Replace spaces and commas with dots
            return price.to_i, currency
        else
            return nil, nil
        end
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

    def price_change
        # ? Shouldn't be the smallest price change instead of average?

        return 0 unless price_records&.any?
      
        oldest_record = price_records.order(date: :asc).first
        old_price = oldest_record.price
      
        sum_price = price_records.sum(:price)
        average_price = sum_price.to_f / price_records.count
      
        return 0 if average_price.zero?
      
        price_difference = old_price - average_price
        difference_percentage = (price_difference / average_price) * 100
      
        difference_percentage.to_i
      end

    def smallest_price
        # Getting the smallest price if any price records
        return 0 unless price_records&.any?
        price_records.sort_by {|price_record| price_record.price}[0].price
    end

end
