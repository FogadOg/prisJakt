class Product < ApplicationRecord
    validates :name, :price, presence: true
    validates :link, :image, presence: true, allow_blank: false
 
end
