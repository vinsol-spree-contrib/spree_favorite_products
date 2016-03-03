module Spree
  class Favorite < ActiveRecord::Base
    belongs_to :product
    belongs_to :user
    validates :user_id, :product_id, presence: true
    validates :product_id, uniqueness: { scope: :user_id, message: "already marked as favorite" }
    validates :product, presence: { message: "is invalid" }, if: :product_id
  end
end
