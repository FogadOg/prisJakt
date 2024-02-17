class Product < ApplicationRecord
    validates :name, presence: true
    validates :image, presence: true, allow_blank: false

    def searchVector(otherTerm)

        tfIdfVector=TextProcessing::TfIdfVector.new()
        tfIdfVector=tfIdfVector.vectorForSearch(name, otherTerm)

        return tfIdfVector
    end

    def saveProductSource(name, price, image, link)
        SourceOfProduct.new(
            productId: id, 
            name: name, 
            price: price, 
            image: image, 
            link: link
            ).save

    end

end
