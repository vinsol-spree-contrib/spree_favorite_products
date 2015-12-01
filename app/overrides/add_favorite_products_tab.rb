Deface::Override.new(
  :virtual_path => 'spree/admin/shared/_main_menu',
  :name => 'add_favorite_products_tab',
  :insert_after => "ul:nth-child(2)",
  :text => %Q{
    <% if can? :admin, Spree::Admin::FavoriteProductsController %>
      <ul class="nav nav-sidebar">
        <%= tab :favorite_products, icon: 'bookmark'  %>
      </ul>
    <% end %>
  }
)
