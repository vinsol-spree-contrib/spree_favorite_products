module Spree
  class Favorite < ActiveRecord::Base

  with_options required: true do
    belongs_to :product
    belongs_to :user
  end

    validates :product_id, uniqueness: { scope: :user_id, message: Spree.t(:duplicate_favorite), allow_blank: true }
  end
end
