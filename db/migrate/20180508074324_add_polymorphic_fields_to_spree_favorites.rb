class AddPolymorphicFieldsToSpreeFavorites < ActiveRecord::Migration[5.1]
  def change
    add_reference(:spree_favorites, :favoritable, polymorphic: true, index: true)
  end
end
