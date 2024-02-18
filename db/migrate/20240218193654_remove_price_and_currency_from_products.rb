class RemovePriceAndCurrencyFromProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :price, :decimal
    remove_column :products, :currency, :string
  end
end
