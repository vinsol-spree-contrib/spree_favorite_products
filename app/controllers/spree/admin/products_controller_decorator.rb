Spree::Admin::ProductsController.class_eval do

  before_action :set_variant, only: :favorite_users

  def favorite_users
    if params[:type] == 'variant'
      @users = Spree::User.joins(:favorite_variants).
                           where(spree_favorites: { favoritable_id: @variant.id, favoritable_type: 'Spree::Variant' })
    else
      @users = Spree::User.joins(:favorite_products).
                           where(spree_favorites: { favoritable_id: @product.id, favoritable_type: 'Spree::Product' })
    end
  end

  private

    def set_variant
      return if params[:type] != 'variant'

      @variant = Spree::Variant.find_by(id: params[:item_id])
      unless @variant.present?
        flash[:error] = Spree.t(:variant_does_not_exist)
        redirect_to admin_products_path
      end
    end

end
