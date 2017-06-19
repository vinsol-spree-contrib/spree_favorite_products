Deface::Override.new(
  virtual_path: 'spree/admin/shared/_product_tabs',
  name: 'add_favorite_users_tab_to_products',
  insert_bottom: "[data-hook='admin_product_tabs']",
  text: %Q{
          <li<%== ' class="active"' if current == :favorited_by %>>
            <%= link_to_with_icon 'user', Spree.t(:favorited_by), spree.favorite_users_admin_product_path(@product) %>
          </li>
        }
)
