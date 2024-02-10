class CreateSourceOfProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :source_of_products do |t|
      t.integer :productId
      t.string :name
      t.string :price
      t.string :image

      t.timestamps
    end
  end
end
