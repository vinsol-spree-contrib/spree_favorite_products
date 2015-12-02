Deface::Override.new(
  :virtual_path => 'spree/admin/shared/sub_menu/_product',
  :name => 'select_products_tab',
  :insert_bottom => "#sidebar-product",
  :text => %Q{ <%= tab :favorite_products %> }
)
