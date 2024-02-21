class AddNullConstraintsToPriceRecords < ActiveRecord::Migration[7.1]
  def change
    change_column :price_records, :product_id, :integer, null: false
    change_column :price_records, :price, :integer, null: false
  end
end
