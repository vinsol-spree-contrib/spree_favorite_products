Deface::Override.new(
  :virtual_path => 'spree/admin/general_settings/edit',
  :name => 'add_favorite_products_per_page_configuration',
  :insert_after => "#preferences .row",
  :text => %Q{
    <div class="row">
      <fieldset class="no-border-bottom">
        <legend align="center"><%= Spree.t(:favorite_products_settings) %></legend>
        <div class="field">
          <%= label_tag :favorite_products_per_page, Spree.t(:favorite_products_per_page) %><br>
          <%= text_field_tag :favorite_products_per_page, Spree::Config[:favorite_products_per_page], :size => 3 %>
        </div>
      </fieldset>
    </div>
  }
)