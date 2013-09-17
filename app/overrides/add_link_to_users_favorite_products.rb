Deface::Override.new(
  :virtual_path => "spree/shared/_nav_bar",
  :name => "add_link_to_users_favorite_products",
  :insert_before => "li#search-bar",
  :text => "<% if spree_current_user %><li><%= link_to 'Favorite Products', favorite_products_path %></li><% end %>",
  :sequence => { :before => "auth_shared_login_bar"}
)

