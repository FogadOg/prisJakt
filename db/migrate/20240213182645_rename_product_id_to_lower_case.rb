class RenameProductIdToLowerCase < ActiveRecord::Migration[7.1]
  def change
    rename_column :price_records, :ProductId, :productId
  end
end
