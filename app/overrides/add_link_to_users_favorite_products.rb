if Spree.version.to_f > 4.0
  Deface::Override.new(
    virtual_path: "spree/shared/_link_to_account",
    name: "add_link_to_users_favorite_products",
    insert_after: "erb[loud]:contains('spree.account_path')",
    text: "<% if spree_current_user %><li><%= link_to Spree.t('favorite_product_uppercase'), favorite_products_path , class: 'dropdown-item' %></li><% end %>"
  )
else
  Deface::Override.new(
    virtual_path: "spree/shared/_main_nav_bar",
    name: "add_link_to_users_favorite_products",
    insert_after: "#home-link",
    text: "<% if spree_current_user %><li><%= link_to 'Favorite Products', favorite_products_path %></li><% end %>",
    sequence: { before: "auth_shared_login_bar"}
  )
end

