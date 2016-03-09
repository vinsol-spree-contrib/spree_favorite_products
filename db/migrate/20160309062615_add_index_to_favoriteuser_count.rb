class AddIndexToFavoriteuserCount < ActiveRecord::Migration
  def change
    add_index :spree_products, :favorite_users_count
  end
end
