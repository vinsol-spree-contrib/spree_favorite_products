module Spree
  class FavoriteProductsController < Spree::StoreController

    before_action :store_favorite_product_preference, only: :create
    before_action :authenticate_spree_user!, except: :change_favorite_option
    before_action :find_favorite_product, only: :destroy

    def index
      @favorite_products = spree_current_user.favorite_products
      @favorite_variants = spree_current_user.favorite_variants
    end

    def create
      favorite = spree_current_user.favorites.new(permitted_params)
      if @success = favorite.save
        @message = Spree.t(:success, scope: [:favorite_products, :create])
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

    def change_favorite_option
      set_variant

      respond_to do |format|
        format.js
      end
    end

    private
      def find_favorite_product
        @favorite = spree_current_user.favorites.where(permitted_params).first
      end

      def store_favorite_product_preference
        unless spree_current_user
          if params[:type] == 'Spree::Product'
            session[:spree_user_return_to] = product_path(id: params[:id], favorite_product_id: params[:id], type: 'product')
          else
            variant = Spree::Variant.find_by(id: params[:id])
            session[:spree_user_return_to] = product_path(id: variant.product.id, favorite_product_id: params[:id], type: 'variant')
          end
          redirect_to login_path, notice: Spree.t(:login_to_add_favorite)
        end
      end

      def permitted_params
        {
          favoritable_id: params[:id],
          favoritable_type: params[:type]
        }
      end

      def set_variant
        if spree_current_user.present?
          find_favorite_product
        end
      end
  end
end
