Spree::User.class_eval do 
  has_many :favorites
  has_many :favorite_products, :through => :favorites, :class_name => 'Spree::Product', :source => 'product'

  def has_favorite_product?(product_id)
    favorites.exists? :product_id => product_id
  end
end