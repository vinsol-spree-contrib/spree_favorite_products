Deface::Override.new(
  virtual_path: 'spree/admin/users/_sidebar',
  name: 'add_favorite_products_tab_to_users',
  insert_bottom: "[data-hook='admin_user_tab_options']",
  text: %Q{
          <li<%== ' class="active"' if current == :favorite_products %>>
            <%= link_to_with_icon 'th-large', Spree.t(:favorite_product), spree.favorite_products_admin_user_path(@user) %>
          </li>
        }
)
