class RenameFavoritesToSpreeFavorites < SpreeExtension::Migration[4.2]
  def change
    rename_table :favorites, :spree_favorites
    add_index :spree_favorites, [:user_id, :product_id], unique: true
    add_index :spree_favorites, :user_id
  end
end
