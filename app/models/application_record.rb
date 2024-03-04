class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  def extract_price_and_currency(string)
    match = string.match(/(\D+)\s*([\d\s]+)/)
    if match
      currency = match[1].strip
      price = match[2].strip.gsub(/\s+/, '').to_i
      return price, currency
    else
      return nil, nil
    end


  end
end
