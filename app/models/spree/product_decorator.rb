module Spree
  module ProductDecorator
	  	def self.prepended(base)
	      base.has_many :favorites, as: :favoritable, dependent: :destroy
	      base.has_many :favorite_users, through: :favorites, class_name: 'Spree::User', source: :user
	      base.scope :favorite, -> { joins(:favorites).distinct }
	      base.scope :order_by_favorite_users_count, ->(asc = false) { order(favorite_users_count: "#{asc ? 'asc' : 'desc'}") }
	    end
	end
end
::Spree::Product.prepend(Spree::ProductDecorator)