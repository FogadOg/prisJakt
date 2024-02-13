class CreateCustomProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :custom_products do |t|
      t.integer :userId
      t.string :image
      t.string :name
      t.string :price
      t.string :url

      t.timestamps
    end
  end
end
