class ScrapersService
  def call(search_terms:["air jordan 1"])

    scrape_record = ScrapeRecord.new(date:Date.today)
    scrape_record.save

    scrape_record_id=scrape_record.id.to_i

    search_terms.each do |searchTerm|
      ScraperComponent::Scraper::NikeScraper.new("https://www.nike.com/no/w?q=",searchTerm, scrape_record_id)
      ScraperComponent::Scraper::ZalandoScraper.new("https://www.zalando.no/herre/?q=", searchTerm ,scrape_record_id)

    end

    new_price_record_for_all_sources(scrape_record_id)
  end

  def new_price_record_for_all_sources(scrape_record_id)
    Product.all.each do |product|
      if product.price_records.where(batch: scrape_record_id).empty?
        product.source_of_products.each do |source_of_product|
          source_of_product.newPriceRecord(scrape_record_id, scrape_record_id)

        end
      end
    end
  end
  end