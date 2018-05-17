module Spree
  class FavoriteProductsController < Spree::StoreController

    before_action :store_favorite_product_preference, only: :create
    before_action :authenticate_spree_user!, except: :get_favoritable_value
    before_action :find_favorite_product, only: :destroy

    def index
      @favorite_products = spree_current_user.favorite_products
      @favorite_variants = spree_current_user.favorite_variants
    end

    def create
      favorite = spree_current_user.favorites.new(favoritable_params)
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
      @success = @favorite.destroy
    end

    # returns whether user has favorited a product/variant or not
    def get_favoritable_value
      if spree_current_user.present?
        @favorite = spree_current_user.favorites.where(favoritable_params).first
      end

      respond_to do |format|
        format.js
      end
    end

    private
      def find_favorite_product
        @favorite = spree_current_user.favorites.where(favoritable_params).first

        unless @favorite.present?
          respond_to do |format|
            format.html { redirect_to products_path, notice: Spree.t(:product_not_found) }
            format.js do
              render :not_found, status: 422 and return
            end
          end
        end
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

      def favoritable_params
        {
          favoritable_id: params[:id],
          favoritable_type: params[:type]
        }
      end
  end
end
