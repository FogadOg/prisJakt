require 'nokogiri'
require 'open-uri'

module ScraperComponent::Scraper
  class BaseScraper
    def initialize(url, searchTerm, joiningSymbole)
      @searchTerm = searchTerm
      @joiningSymbole = joiningSymbole
      @url = url

      requestUrl = requestUrl()

      htmlContent = URI.open(requestUrl, 'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36')
      @doc = Nokogiri::HTML(htmlContent)
    end

    def requestUrl
      return @url if @searchTerm.nil?

      searchTerm = @searchTerm.gsub(" ", @joiningSymbole)
      @url + searchTerm
    end
  end
end
