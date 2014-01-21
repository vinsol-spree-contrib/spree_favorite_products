SpreeFavoriteProducts
=====================

This extension adds the following features:
1. Adds a link 'Mark as favorite' on product detail page.
2. Favorite Products tab on header
3. Favorite Products tab in admin section 

Installation
------------

Add spree_favorite_products to your Gemfile:

```ruby
gem 'spree_favorite_products'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_favorite_products:install
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_favorite_products/factories'
```

Copyright (c) 2014 Vinsol, released under the New MIT License
