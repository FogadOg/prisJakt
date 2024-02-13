class CreatePriceRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :price_records do |t|
      t.integer :ProductId
      t.string :price

      t.timestamps
    end
  end
end
