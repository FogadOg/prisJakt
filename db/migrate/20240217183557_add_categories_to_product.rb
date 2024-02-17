class AddCategoriesToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :categories, :string
  end
end
