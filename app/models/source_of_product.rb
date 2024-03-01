class SourceOfProduct < ApplicationRecord
  belongs_to :product
  validates_associated :product

  def newPriceRecord(batch_id, currency=nil)
    PriceRecord.new(
      product_id:id, 
      price: 500, 
      date:Date.today, 
      currency: "currency",
      batch: batch_id
    ).save   

    
  end

  def processPrice(batch_id)
    # priceNumerical, currency = extractPriceAndCurrancy(price)
        
    PriceRecord.new(
      product_id:id, 
      price: 400, 
      date:Date.today, 
      currency: "currency",
      batch: batch_id
    ).save
  end
end
