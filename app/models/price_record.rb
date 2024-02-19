class PriceRecord < ApplicationRecord
    validates :productId, presence: true
    validates :price, presence: true
    validates :date, presence: true
    belongs_to :product

end
