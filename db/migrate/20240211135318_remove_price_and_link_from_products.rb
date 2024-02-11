class RemovePriceAndLinkFromProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :price, :integer
    remove_column :products, :link, :string
  end
end
