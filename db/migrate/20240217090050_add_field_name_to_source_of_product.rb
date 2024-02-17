class AddFieldNameToSourceOfProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :source_of_products, :link, :string
  end
end
