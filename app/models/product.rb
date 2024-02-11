class Product < ApplicationRecord
    validates :name, presence: true
    validates :image, presence: true, allow_blank: false
 
end
