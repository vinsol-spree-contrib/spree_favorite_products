Deface::Override.new(
  :virtual_path => 'spree/products/show',
  :name => 'add_link_to_mark_product_as_favorite',
  :insert_after => "div[itemprop='description']",
  :text => "<%= link_to 'Mark as favorite', favorite_products_path(:id => @product.id), :method => :post, :remote => spree_user_signed_in? %>"
)