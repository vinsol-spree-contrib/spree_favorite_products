SpreeFavoriteProducts [![Code Climate](https://codeclimate.com/github/vinsol/spree_favorite_products.png)](https://codeclimate.com/github/vinsol/spree_favorite_products) [![Build Status](https://travis-ci.org/vinsol/spree_favorite_products.png?branch=master)](https://travis-ci.org/vinsol/spree_favorite_products)
=====================

This extension adds the following features:
1. Adds a link 'Mark as favorite' on product detail page.
2. Favorite Products tab on header
3. Favorite Products tab in admin section 

It is comptabile with Spree 2.1.x (Rails4)

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

Credits
-------

[![vinsol.com: Ruby on Rails, iOS and Android developers](http://vinsol.com/vin_logo.png "Ruby on Rails, iOS and Android developers")](http://vinsol.com)

Copyright (c) 2014 [vinsol.com](http://vinsol.com "Ruby on Rails, iOS and Android developers"), released under the New MIT License
