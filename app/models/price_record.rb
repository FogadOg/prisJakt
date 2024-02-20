class PriceRecord < ApplicationRecord
    validates :product_id, presence: true
    validates :price, presence: true
    validates :date, presence: true
    belongs_to :product

end
