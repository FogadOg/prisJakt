class PriceRecord < ApplicationRecord
    validates :id, presence: true
    validates :productId, presence: true
    validates :price, presence: true
    validates :date, presence: true
end
