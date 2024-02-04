class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :link
      t.string :name
      t.string :image
      t.string :price

      t.timestamps
    end
  end
end
