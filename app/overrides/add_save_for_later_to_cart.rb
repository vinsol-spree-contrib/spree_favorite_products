Deface::Override.new(
  virtual_path: 'spree/orders/_line_item',
  name: 'add_save_for_later_to_cart',
  insert_bottom: '[data-hook="line_item_description"]',
  text: '<br/>
  <% if variant.is_master %>
    <% if spree_current_user.present? && !spree_current_user.has_favorite_product?(variant.product.id) %>
      <%= link_to Spree.t(:save_for_later), favorite_products_path(id: variant.product.id, type: "Spree::Product"), method: :post, remote: spree_user_signed_in?, id: "favorite_variant_#{variant.product.id}" %>
    <% end %>
  <% else %>
    <% if spree_current_user.present? && !spree_current_user.has_favorite_variant?(variant.id) %>
      <%= link_to Spree.t(:save_for_later), favorite_products_path(id: variant.id, type: "Spree::Variant"), method: :post, remote: spree_user_signed_in?, id: "favorite_variant_#{variant.id}" %>
    <% end %>
  <% end %>
  '
)