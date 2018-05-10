Spree::Admin::ProductsController.class_eval do

  before_action :set_variant, only: :favorite_users

  def favorite_users
    if params[:type] == 'variant'
      set_favorite_variant_users(@variant.id)
    elsif params[:type] == 'product'
      set_favorite_product_users
    else
      set_favorite_product_users
      set_favorite_variant_users(@product.variants.pluck(:id))
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

    def set_favorite_product_users
      @favorite_product_users = Spree::User.joins(:favorite_products).
                           where(spree_favorites: { favoritable_id: @product.id, favoritable_type: 'Spree::Product' }).page(params[:page])
    end

    def set_favorite_variant_users(id)
      return unless id.present?

      @favorite_variant_users = Spree::User.joins(:favorite_variants).
                           where(spree_favorites: { favoritable_id: id, favoritable_type: 'Spree::Variant' }).
                           select('spree_users.*, spree_favorites.favoritable_id').page(params[:page])
    end

end
