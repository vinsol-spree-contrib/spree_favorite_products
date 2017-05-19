Spree::AppConfiguration.class_eval do
  preference :favorite_products_per_page, :integer, default: 10
  preference :favorite_users_per_page, :integer, default: 10
end
