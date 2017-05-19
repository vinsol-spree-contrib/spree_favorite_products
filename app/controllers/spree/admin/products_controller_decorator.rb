Spree::Admin::ProductsController.class_eval do

  def favorite_users
    @users = @product.favorite_users.page(params[:page]).per(10)
  end
end
