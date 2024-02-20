class PriceRecord < ApplicationRecord
    belongs_to :product

    # Checks if products does exist too
    validates_associated :product

    # Checks if products does exist too
    validates_presence_of :price
    validates_presence_of :date

end
