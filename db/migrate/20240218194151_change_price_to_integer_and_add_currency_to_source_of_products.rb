class ChangePriceToIntegerAndAddCurrencyToSourceOfProducts < ActiveRecord::Migration[7.1]
  def change
    change_column :source_of_products, :price, :integer
    add_column :source_of_products, :currency, :string
  end
end
