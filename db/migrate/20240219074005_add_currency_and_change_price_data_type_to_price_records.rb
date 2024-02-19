class AddCurrencyAndChangePriceDataTypeToPriceRecords < ActiveRecord::Migration[7.1]
  def change    
    add_column :price_records, :currency, :string
    change_column :price_records, :price, :integer
  end
end
