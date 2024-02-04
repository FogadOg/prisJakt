module Scraper
    class ScrapeData
        attr_reader :link, :image, :name, :price

        def initialize(link, image, name, price)
            @link=link
            @image=image
            @name=name
            @price=price
        end
        def to_s
            @name.to_s
        end

        def getAttribute(attribute)
          case attribute
          when :link
            return @link
          when :image
            return @image
          when :name
            return @name
          when :price
            return @price
          else
            raise ArgumentError, "Invalid attribute: #{attribute}"
          end
        end

        def save
          newProduct=Product.new(
            link: link,
            image: image,
            name: name,
            price: price
          )
          if newProduct.save
            puts "Product created successfully!"
          else
            puts "Error creating product: #{newProduct.errors.full_messages.join(', ')}"
          end
        end


    end
end