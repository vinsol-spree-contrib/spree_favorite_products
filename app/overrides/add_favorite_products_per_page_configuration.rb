Deface::Override.new(
  :virtual_path => 'spree/admin/general_settings/edit',
  :name => 'add_favorite_products_per_page_configuration',
  :insert_before => "#preferences fieldset .form-actions",
  :text => %Q{
    <div class="row">
      <div class="col-md-6">
        <div class="form-group" data-hook="admin_general_setting_favorite_products_per_page">
          <%= label_tag :favorite_products_per_page, Spree.t(:favorite_products_per_page) %>
          <%= text_field_tag :favorite_products_per_page, Spree::Config[:favorite_products_per_page], :size => 3 %>
        </div>
      </div>
    </div>
  }
)
