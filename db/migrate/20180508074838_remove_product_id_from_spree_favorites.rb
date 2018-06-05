class RemoveProductIdFromSpreeFavorites < ActiveRecord::Migration[5.1]
  def change
    remove_column :spree_favorites, :product_id, :integer
  end
end
