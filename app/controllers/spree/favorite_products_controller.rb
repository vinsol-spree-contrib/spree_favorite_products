module Spree
  class FavoriteProductsController < Spree::StoreController

    before_filter :authenticate_spree_user!, :only => [:index, :create, :destroy]

    def index
      @favorite_products = spree_current_user.favorite_products
    end

    def create
      favorite = spree_current_user.favorites.new :product_id => params[:id]
      if @success = favorite.save
        @message = "Product has been successfully marked as favorite"
      else
        @message = favorite.errors.full_messages.to_sentence
      end
      respond_to do |format|
        format.js
      end
    end

    def destroy
      if @product_id = Spree::Product.where(:permalink => params[:id]).first.try(:id)
        @favorite_product = Spree::Favorite.where("user_id = ? and product_id = ?", spree_current_user.id, @product_id).first
        @success = @favorite_product.try(:destroy)
      else
        @success = false
      end
    end
  end
end