function FavoritableProduct(options) {
  this.$variants = options.$variants;
  this.$productPrice = options.$productPrice;
  this.productFavoriteButton = options.productFavoriteButton;
}

FavoritableProduct.prototype.initialize = function() {
  this.bindEvents();
  this.modifyDisplay();
  this.processParams();
}

FavoritableProduct.prototype.modifyDisplay = function() {
  if(this.$variants.length != 1){  // if product has variants
    this.$variants.prop('checked', false);
    this.$productPrice.hide();
  }
}

FavoritableProduct.prototype.processParams = function() {
  var params = getQueryParams(document.location.search);

  if(!params['favorite_product_id']) {
    return;
  }

  if(params['type'] == 'variant') {
    $('#variant_id_' + params['favorite_product_id']).click();
  } else {
    this.markProductFavorite();
  }
}

FavoritableProduct.prototype.bindEvents = function() {
  this.$variants.on('click', this.changeFavoriteOption());
}

FavoritableProduct.prototype.changeFavoriteOption = function() {
  var _this = this;

  return function() {
    _this.$productPrice.show();

    $.ajax({
      url: '/favorite_products/' + $(this).val() + '/get_favoritable_value',
      method: 'GET',
      dataType: 'script',
      data: { type: 'Spree::Variant' },

      success: function(xhr, status) {
        var params = getQueryParams(document.location.search);
        if (params['favorite_product_id']) {
          _this.markProductFavorite();
        }
      }
    })
  }
}

FavoritableProduct.prototype.markProductFavorite = function() {
  var $productFavoriteButton = $(this.productFavoriteButton); //fetch product

  if($productFavoriteButton) {
    $productFavoriteButton.attr('data-remote', true);
    $productFavoriteButton.trigger('click');
    window.history.pushState({}, document.title, window.location.pathname); // remove query param
  }
}

$(function() {
  var options = {
    $variants: $('input[name="variant_id"]'),
    $productPrice: $('[data-hook="product_price"]'),
    productFavoriteButton: '#mark-as-favorite'
  },
  favoritableProduct = new FavoritableProduct(options);
  favoritableProduct.initialize();
})