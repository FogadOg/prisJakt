class Product < ApplicationRecord
    validates :name, presence: true
    validates :image, presence: true, allow_blank: false

    def searchVector(otherTerm)

        tfIdfVector=TextProcessing::TfIdfVector.new()
        tfIdfVector=tfIdfVector.vectorForSearch(name, otherTerm)

        return tfIdfVector
    end
 
end
