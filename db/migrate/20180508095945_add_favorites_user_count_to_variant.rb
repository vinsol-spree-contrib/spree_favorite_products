class AddFavoritesUserCountToVariant < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_variants, :favorite_users_count, :integer, default: 0
    add_index :spree_variants, :favorite_users_count
  end
end
