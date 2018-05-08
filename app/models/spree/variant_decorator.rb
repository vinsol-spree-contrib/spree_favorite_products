Spree::Variant.class_eval do
  has_many :favorites, as: :favoritable, dependent: :destroy
  has_many :favorite_users, through: :favorites, class_name: 'Spree::User', source: :user

  scope :favorite, -> { joins(:favorites).distinct }
end
