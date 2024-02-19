class SourceOfProductRenameproductIdToproductId < ActiveRecord::Migration[7.1]
  def change
    rename_column :source_of_products, :productId, :product_id
  end
end
