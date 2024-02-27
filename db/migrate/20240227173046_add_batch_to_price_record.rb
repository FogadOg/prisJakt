class AddBatchToPriceRecord < ActiveRecord::Migration[7.1]
  def change
    add_column :price_records, :batch, :integer
  end
end
