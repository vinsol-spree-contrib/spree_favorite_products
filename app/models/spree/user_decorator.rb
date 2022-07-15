module Spree
  module UserDecorator
  		def self.prepended(base)
		  base.has_many :favorites, dependent: :destroy
		  base.has_many :favorite_products, through: :favorites, source: :favoritable, source_type: 'Spree::Product'
		  base.has_many :favorite_variants, through: :favorites, source: :favoritable, source_type: 'Spree::Variant'
		end
		  def has_favorite_product?(product_id)
		    favorites.exists? favoritable_id: product_id, favoritable_type: 'Spree::Product'
		  end

		  def has_favorite_variant?(variant_id)
		    favorites.exists? favoritable_id: variant_id, favoritable_type: 'Spree::Variant'
		  end
	end
end
::Spree::User.prepend(Spree::UserDecorator)
