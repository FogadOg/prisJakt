class ScraperController < ApplicationController
    include ScraperHelper
    def index

        scrape_record = ScrapeRecord.new(date:Date.today)
        scrape_record.save

        scrape_record_id=scrape_record.id.to_i
       
        searchTerms=[
            "air jordan 1"
        ]
        searchTerms.each do |searchTerm|
            ScraperComponent::Scraper::ZalandoScraper.new("https://www.zalando.no/herre/?q=", searchTerm ,scrape_record_id)
            ScraperComponent::Scraper::NikeScraper.new("https://www.nike.com/no/w?q=",searchTerm, scrape_record_id)

        end

        new_price_record_for_all_sources(scrape_record_id)
        
        # Product.all.each do |product|
        #     product.newPriceRecord(product.price)
        # end

        render json:{status:"200 success"}
    end

    def new_price_record_for_all_sources(scrape_record_id)
        Product.all.each do |product|
            priceRecords=PriceRecord.where(product_id: product.id)
            if priceRecords.where(batch: scrape_record_id).empty?
                SourceOfProduct.where(product_id: product.id).each do |source_of_product|
                    product.newPriceRecord(source_of_product.price, scrape_record_id, "kr")
                
                end
            end
        end

    end
end
