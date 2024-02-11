require_relative '../services/tfIdfService'
require_relative '../textprocessing/textProcess'

module Scraper
  class ScrapeData
    attr_reader :image, :name, :category

    def initialize(image, name, category)
      @image=image
      @name=name
      @category=category
    end
    def to_s
        @name.to_s
    end

    def getAttribute(attribute)
      case attribute
      when :image
        return @image
      when :name
        return @name
      when :category
        return @category
      else
        raise ArgumentError, "Invalid attribute: #{attribute}"
      end
    end

    def save
      newProduct=Product.new(
        image: image,
        name: name,
        category: category
      )
      if newProduct.save
        puts "Product created successfully!"
        _addTermsToIdfCount(@name)

      else
        puts "Error creating product: #{newProduct.errors.full_messages.join(', ')}"
      end
    end

    def _addTermsToIdfCount(sentance)
      textPreprocess=TextProcessing::TextProcess.new(sentance)
      processedText=textPreprocess.process

      splitSentance=processedText.split
      jsonService=Service::TfIdfService.new("idfCount.json")

      removedDuplicateWords=splitSentance.uniq

      removedDuplicateWords.each do |word|
        jsonService.incrementTerm(word)
      end

    end


  end
end