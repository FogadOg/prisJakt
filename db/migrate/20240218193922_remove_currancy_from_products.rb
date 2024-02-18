class RemoveCurrancyFromProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :currancy, :string
  end
end
