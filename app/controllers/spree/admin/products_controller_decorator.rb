Spree::Admin::ProductsController.class_eval do

  def favorite_users
    @search = Spree::Variant.ransack(params[:q])

    if params[:q].present?
      @variant = Spree::Variant.find_by(sku: params[:q][:sku_eq])
      @favorite_variant_users = Spree::User.joins(:favorite_variants).where(spree_favorites: { favoritable_id: @variant.try(:id), favoritable_type: 'Spree::Variant' })
    else
      variant_ids = @product.variants.pluck(:id)
      @favorite_product_users = Spree::User.joins(:favorite_products).where(spree_favorites: { favoritable_id: @product.id, favoritable_type: 'Spree::Product' })
      @favorite_variant_users = Spree::User.joins(:favorite_variants).where(spree_favorites: { favoritable_id: variant_ids, favoritable_type: 'Spree::Variant' })
    end

    @results = @search.result
  end
end
