module Spree
  class FavoriteProductsController < Spree::StoreController

    before_filter :authenticate_spree_user!
    before_filter :find_favorite_product, :only => :destroy

    def index
      @favorite_products = spree_current_user.favorite_products.page(params[:page]).per(Spree::Config.favorite_products_per_page)
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
      if @favorite
        @success = @favorite.destroy
      end
    end

    private
      def find_favorite_product
        @favorite = spree_current_user.favorites.joins(:product).where(:spree_products => {:id => params[:id]}).first
      end
  end
end