Spree::Admin::ProductsController.class_eval do

  def favorite_users
    @users = @product.favorite_users.page(params[:page]).per(Spree::Config.favorite_products_per_page)
  end
end
