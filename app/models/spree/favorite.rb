module Spree
  class Favorite < ActiveRecord::Base
    with_options required: true do
      belongs_to :product, counter_cache: :favorite_users_count
      belongs_to :user
    end

    validates :product_id, uniqueness: { scope: :user_id, message: Spree.t(:duplicate_favorite), allow_blank: true }

    scope :with_product_id, ->(id) { joins(:product).readonly(false).merge(Spree::Product.where(id: id)) }
  end
end
