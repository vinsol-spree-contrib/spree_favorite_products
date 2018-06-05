Spree::Variant.class_eval do
  has_many :favorites, as: :favoritable, dependent: :destroy
  has_many :favorite_users, through: :favorites, class_name: 'Spree::User', source: :user

  scope :favorite, -> { joins(:favorites).distinct }
  scope :order_by_favorite_users_count, ->(asc = false) { order(favorite_users_count: "#{asc ? 'asc' : 'desc'}") }
end
