Deface::Override.new(
  virtual_path: 'spree/products/show',
  name: 'add_javascript_to_product_show',
  insert_before: %Q(erb[silent]:contains(" @body_id = 'product-details' ")),
  text: "<%= javascript_include_tag 'spree/frontend/favoritable_product.js' %>"
)