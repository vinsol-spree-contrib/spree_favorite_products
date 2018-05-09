Spree::Admin::UsersController.class_eval do
  def favorite_products
    @favorite_products = @user.favorite_products
    @favorite_variants = @user.favorite_variants
  end
end
