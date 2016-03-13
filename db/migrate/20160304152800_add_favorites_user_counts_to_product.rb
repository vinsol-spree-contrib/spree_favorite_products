class AddFavoritesUserCountsToProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :favorite_users_count, :integer, default: 0
    add_index :spree_products, :favorite_users_count
  end
end
