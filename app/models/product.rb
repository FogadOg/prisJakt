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

    def saveProductSource(price, image, link, batch_id)
        priceNumerical, currency = extractPriceAndCurrancy(price)
        sourceOfProduct=SourceOfProduct.new(
            product_id: id, 
            name: name, 
            price: priceNumerical, 
            image: image, 
            link: link,
            currency: currency
        )
        sourceOfProduct.newPriceRecord(id, batch_id)
        sourceOfProduct.save

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
