module ScraperComponent::Scraper
    class NikeScraper < BaseScraper
        def initialize(url, searchTerm, batchId)
            super(url, searchTerm, batchId)
            scrape()
        end
        
        def scrape

            pageHtml=ScraperComponent::ScraperUtil.new(@doc)

            logo="https://cdn.mos.cms.futurecdn.net/786NzPhpXo6G8hkutJkHTM-1200-80.jpg"

            products=pageHtml.getProducts(".product-card.product-grid__card.css-1t0asop")
            ScraperComponent::ProcessProducts.new(products.element, logo, @batchId).save(
                ".product-card__link-overlay",
                ".product-card__hero-image.css-1fxh5tw",               
                ".product-card__title",
                ".product-price.is--current-price.css-1ydfahe")

        end
        
    end
end
