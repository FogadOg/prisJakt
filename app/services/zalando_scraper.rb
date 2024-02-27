class ScrapeZalandoService
  def call(search_terms:["air jordan 1 mid"])

    scrape_record = ScrapeRecord.new(date:Date.today)
    scrape_record.save

    scrape_record_id=scrape_record.id.to_i

    search_terms.each do |searchTerm|
      ScraperComponent::Scraper::ZalandoScraper.new("https://www.zalando.no/herre/?q=", searchTerm ,scrape_record_id)
    end

    new_price_record_for_all_sources(scrape_record_id)
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