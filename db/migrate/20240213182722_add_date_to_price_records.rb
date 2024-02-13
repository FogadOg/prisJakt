class AddDateToPriceRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :price_records, :date, :date
  end
end
