Spree Favorite Products [![Code Climate](https://codeclimate.com/github/vinsol/spree_favorite_products.png)](https://codeclimate.com/github/vinsol/spree_favorite_products) [![Build Status](https://travis-ci.org/vinsol/spree_favorite_products.png?branch=master)](https://travis-ci.org/vinsol/spree_favorite_products)
=====================

This extension adds the following features:

1. Adds a link 'Mark as favorite' on product detail page.
2. Favorite Products tab on header
3. Favorite Products tab in admin section

Installation
------------

Add spree_favorite_products to your Gemfile:

```ruby
gem 'spree_favorite_products', github: "vinsol/spree_favorite_products', branch: '2-3-stable'
```

This is for Spree version 2.3.  For older versions of spree, use the correct branch.

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

Thought you should know:
During the test app build, there will be two warnings that arise due to a habtm issue, see [rails issue #15022](https://github.com/rails/rails/issues/15022)

```shell
/Users/deft/vendor/bundle/gems/activerecord-4.1.6/lib/active_record/associations.rb:1585: warning: already initialized constant Spree::ShippingMethod::HABTM_Zones
/Users/deft/vendor/bundle/gems/activerecord-4.1.6/lib/active_record/associations.rb:1585: warning: previous definition of HABTM_Zones was here
```
These warnings do not appear to interfere with functionality. Please let me know otherwise.


Contributing
------------

1. Fork the repo.
2. Clone your repo.
3. Run `bundle install`.
4. Run `bundle exec rake test_app` to create the test application in `spec/test_app`.
5. Make your changes.
6. Ensure specs pass by running `bundle exec rspec spec`.
7. Submit your pull request.

Credits
-------

[![vinsol.com: Ruby on Rails, iOS and Android developers](http://vinsol.com/vin_logo.png "Ruby on Rails, iOS and Android developers")](http://vinsol.com)

Copyright (c) 2014 [vinsol.com](http://vinsol.com "Ruby on Rails, iOS and Android developers"), released under the New MIT License
