module Spree
  module Admin
    class FavoriteProductsController < Spree::Admin::BaseController

      def index
        @favorite_products = Spree::Product.favorite.page(params[:page])
      end

      def users
        @product = Spree::Product.where(:id => params[:id]).first
        @users = @product.favorite_users.page(params[:page])
      end
    end
  end
end