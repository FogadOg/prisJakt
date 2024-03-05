module ScraperComponent::Scraper
    class SneakershopScraper < BaseScraper
        def initialize(url, searchTerm, batchId)
            super(url, searchTerm, batchId)
            scrape()
        end
        
        def scrape

            pageHtml=ScraperComponent::ScraperUtil.new(@doc)

            logo="https://titanarena.ru/wp-content/uploads/2017/01/cybr-400x400.png"


            # def save(linkSelector, imageSelector, nameSelector, priceSelector)
            products = pageHtml.getProducts("[class*='column']")
            ScraperComponent::ProcessProducts.new(products.element, logo, @batchId).save(
                ".stretched-link",
                "[class*='media-image'][class*='position:center']",           
                "[class*='product-card-title']",           
                "[class*='price-value']")

        end
        
    end
end
