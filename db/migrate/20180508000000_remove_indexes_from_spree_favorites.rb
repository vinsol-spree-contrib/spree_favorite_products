class RemoveIndexesFromSpreeFavorites < ActiveRecord::Migration[5.1]
  def change
    remove_index :spree_favorites, [:user_id, :product_id]
  end
end
