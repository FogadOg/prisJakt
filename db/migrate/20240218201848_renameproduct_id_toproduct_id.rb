class RenameproductIdToproductId < ActiveRecord::Migration[7.1]
  def change
    rename_column :price_records, :productId, :product_id

  end
end
