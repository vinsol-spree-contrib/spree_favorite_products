Spree::Product.class_eval do
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, class_name: 'Spree::User', source: 'user'

  def self.favorite
    joins(:favorites).group(:product_id)
  end

  def self.order_by_favorite_users_count(asc=false)
    order("count(spree_favorites.user_id) #{asc ? 'asc' : 'desc'}")
  end
end
