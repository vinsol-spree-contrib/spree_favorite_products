# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_favorite_products'
  s.version     = '2.2.3'
  s.summary     = 'Favorite Products in Spree'
  s.description = 'This extension adds the following features: 1. Adds a link Mark as favorite on product detail page. 2. Favorite Products tab on header 3. Favorite Products tab in admin section'
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'Mohit Bansal'
  s.email     = 'info@vinsol.com'
  s.homepage  = 'http://vinsol.com'
  s.license   = "MIT"

  s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 3.0.0'
end
