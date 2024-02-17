class PriceRecord < ApplicationRecord
    validates :productId, presence: true
    validates :price, presence: true
    validates :date, presence: true
end
