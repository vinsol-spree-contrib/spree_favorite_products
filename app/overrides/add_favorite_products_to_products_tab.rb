Deface::Override.new(
  :virtual_path => 'spree/admin/shared/_tabs',
  :name => 'select_products_tab',
  :replace => "erb[silent]:contains('if can? :admin, Spree::Product')",
  :closing_selector => "erb[silent]:contains('end')",
  :text => %Q{
    <% if can? :admin, Spree::Product %>
      <%= tab :products, :option_types, :properties, :prototypes, :variants, :product_properties, :taxonomies, :favorite_products, :icon => 'icon-th-large' %>
    <% end %>
  } 
)