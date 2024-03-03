class SourceOfProduct < ApplicationRecord
  belongs_to :product
  validates_associated :product

  def newPriceRecord(product_id, batch_id)
    PriceRecord.new(
      product_id:product_id, 
      price: price, 
      date:Date.today, 
      currency: currency,
      batch: batch_id
    ).save
  end
end
