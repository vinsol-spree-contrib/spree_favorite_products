Spree::User.class_eval do 
  has_many :favorites
  has_many :favorite_products, :through => :favorites, :class_name => 'Spree::Product', :source => 'product'
end