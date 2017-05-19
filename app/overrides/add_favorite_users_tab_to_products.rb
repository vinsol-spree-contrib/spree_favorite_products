Deface::Override.new(
  virtual_path: 'spree/admin/shared/_product_tabs',
  name: 'add_favorite_users_tab_to_products',
  insert_bottom: "[data-hook='admin_product_tabs']",
  text: %Q{
          <li<%== ' class="active"' if current == :favorite_user %>>
            <%= link_to_with_icon 'user', Spree.t(:favorite_user), spree.favorite_users_admin_product_path(@product) %>
          </li>
        }
)
