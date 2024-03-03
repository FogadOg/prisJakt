class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  def extractPriceAndCurrancy(string)
    currency_pattern = /(\$|€|£|kr)/
    price_pattern = /\d+(\.\d+)?/

    currency_match = string.match(currency_pattern)
    price_match = string.match(price_pattern)
  
    if currency_match && price_match
      currency = currency_match[0]
      price = price_match[0].to_i
      return price, currency
    else
      return nil, nil
    end


  end
end
