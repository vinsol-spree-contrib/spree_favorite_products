module Spree
  class Favorite < ActiveRecord::Base
    belongs_to :product, required: true
    belongs_to :user, required: true

    validates :product_id, uniqueness: { scope: :user_id, message: Spree.t(:duplicate_favorite), allow_blank: true }
  end
end
