# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_favorite_products'
  s.version     = '3.2.0.rc2'
  s.summary     = 'Favorite Products in Spree'
  s.description = 'This extension adds the following features: 1. Adds a link Mark as favorite on product detail page. 2. Favorite Products tab on header 3. Favorite Products tab in admin section'
  s.required_ruby_version = '>= 2.1.0'

  s.author    = 'Mohit Bansal'
  s.email     = 'info@vinsol.com'
  s.homepage  = 'http://vinsol.com'
  s.license   = "MIT"

  s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 3.2.0.rc2'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'sass-rails', '~> 5.0'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'pg'
end
