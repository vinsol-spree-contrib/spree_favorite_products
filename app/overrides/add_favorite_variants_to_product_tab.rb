Deface::Override.new(
  virtual_path: 'spree/admin/shared/sub_menu/_product',
  name: 'add_favorite_variants_to_product_tab',
  insert_bottom: "#sidebar-product",
  text: %Q{ <%= tab :favorite_variants %> },
  sequence: { after: 'select_products_tab' }
)
