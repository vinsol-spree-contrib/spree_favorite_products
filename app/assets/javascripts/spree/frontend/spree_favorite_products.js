var getQueryParams = function(queryString) {
  queryString = queryString.split('+').join(' ');

  var params = {},
    tokens,
    re = /[?&]?([^=]+)=([^&]*)/g;

  while (tokens = re.exec(queryString)) {
    params[decodeURIComponent(tokens[1])] = decodeURIComponent(tokens[2]);
  }

  return params;
}

$(document).ready(
  function(){
    var params = getQueryParams(document.location.search);
    if(params['favorite_product_id'] != null){
      $('#mark-as-favorite').attr('data-remote', true);
      $('#mark-as-favorite').trigger('click');
    }
  }
);
