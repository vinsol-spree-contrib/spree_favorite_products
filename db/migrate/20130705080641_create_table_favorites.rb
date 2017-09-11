class CreateTableFavorites < SpreeExtension::Migration[4.2]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :product_id
      t.timestamps null: false
    end
  end
end
