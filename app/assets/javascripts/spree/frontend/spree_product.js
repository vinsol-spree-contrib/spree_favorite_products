function SpreeProduct(options) {
  this.$variants = options.$variants;
}

SpreeProduct.prototype.initialize = function() {
  this.removeInitialCheckedState();
  this.bindEvents();
}

SpreeProduct.prototype.removeInitialCheckedState = function() {
  this.$variants.prop('checked', false);
}

SpreeProduct.prototype.bindEvents = function() {
  var _this = this;
  this.$variants.on('change', _this.changeFavoriteOption());
}

SpreeProduct.prototype.changeFavoriteOption = function() {
  var _this = this;

  return function() {
    $.ajax({
      url: '/favorite_products/' + $(this).val() + '/change_favorite_option',
      method: 'GET',
      dataType: 'script',
      data: { type: 'Spree::Variant' },

      success: function(xhr, status) {},

      error: function(e) {}
    })
  }
}

$(function() {
  var options = {
    $variants: $('input[name="variant_id"]')
  },
  spreeProduct = new SpreeProduct(options);
  spreeProduct.initialize();
})