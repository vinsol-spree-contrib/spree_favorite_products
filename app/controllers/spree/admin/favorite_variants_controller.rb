module Spree
  module Admin
    class FavoriteVariantsController < Spree::Admin::BaseController

      def index
        @search = Spree::Variant.favorite.includes(:product, :images).joins(:product).search(params[:q])
        @favorite_variants = @search.result.order_by_favorite_users_count(sort_in_ascending_users_count?).page(params[:page]).per(Spree::Config.favorite_products_per_page)
      end

      private
        def sort_in_ascending_users_count?
          params[:q] && params[:q][:s] == 'favorite_users_count asc'
        end
    end
  end
end
