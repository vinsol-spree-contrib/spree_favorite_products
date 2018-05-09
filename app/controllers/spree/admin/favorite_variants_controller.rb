module Spree
  module Admin
    class FavoriteVariantsController < Spree::Admin::BaseController

      def index
        @search = Spree::Variant.favorite.includes(:product, :images).joins(:product).search(params[:q])
        @favorite_variants = @search.result.order_by_favorite_users_count(sort_in_ascending_users_count?).page(params[:page])
      end

      def destroy
        @favorite = Spree::Favorite.find_by(id: params[:id])
        if @favorite.destroy
          flash[:success] = flash_message_for(@favorite, :successfully_removed)
        else
          flash[:error] = @favorite.errors.full_messages.join(', ')
        end

        respond_with(@favorite) do |format|
          format.html { redirect_to location_after_destroy }
          format.js   { render_js_for_destroy }
        end
      end

      private
        def sort_in_ascending_users_count?
          params[:q] && params[:q][:s] == 'favorite_users_count asc'
        end
    end
  end
end
