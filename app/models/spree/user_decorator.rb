Spree::User.class_eval do
  has_many :favorites, dependent: :destroy
  has_many :favorite_products, through: :favorites, source: :favoritable, source_type: 'Spree::Product'
  has_many :favorite_variants, through: :favorites, source: :favoritable, source_type: 'Spree::Variant'

  def has_favorite_product?(product_id)
    favorites.exists? favoritable_id: product_id, favoritable_type: 'Spree::Product'
  end

  def has_favorite_variant?(variant_id)
    favorites.exists? favoritable_id: variant_id, favoritable_type: 'Spree::Variant'
  end
end
