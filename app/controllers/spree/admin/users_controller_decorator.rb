Spree::Admin::UsersController.class_eval do
  def favorite_products
    @favorite_products = @user.favorite_products.page(params[:page]).per(Spree::Config.favorite_products_per_page)
  end
end
