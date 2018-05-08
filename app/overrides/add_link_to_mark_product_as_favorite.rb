Deface::Override.new(
  virtual_path: 'spree/products/show',
  name: 'add_link_to_mark_product_as_favorite',
  surround_contents: "h1[itemprop='name']",
  text: %Q{
    <%= render_original %>
    <% if spree_user_signed_in? && spree_current_user.has_favorite_product?(@product.id) %>
      <%= link_to Spree.t(:unmark_as_favorite), favorite_product_path(id: @product.id, type: 'Spree::Product'), method: :delete, remote: true, class: 'favorite_link btn btn-primary pull-right', id: 'unmark-as-favorite' %>
    <% else %>
      <%= link_to Spree.t(:mark_as_favorite), favorite_products_path(id: @product.id, type: 'Spree::Product'), method: :post, remote: spree_user_signed_in?, class: 'favorite_link btn btn-primary pull-right', id: 'mark-as-favorite' %>
    <% end %>
  }
)
