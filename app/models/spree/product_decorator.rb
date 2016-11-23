Spree::Product.class_eval do
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, class_name: 'Spree::User', source: :user

  scope :favorite, -> { joins(:favorites).uniq }

  scope :order_by_favorite_users_count, ->(asc = false) { order(favorite_users_count: "#{asc ? 'asc' : 'desc'}") }
end
