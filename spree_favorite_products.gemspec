# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_favorite_products'
  s.version     = '3.3.0'
  s.summary     = 'Favorite Products in Spree'
  s.description = 'This extension adds the following features: 1. Adds a link Mark as favorite on product detail page. 2. Favorite Products tab on header 3. Favorite Products tab in admin section'
  s.required_ruby_version = '>= 2.2.7'

  s.author    = ['Mohit Bansal', 'Anurag Bharadwaj', '+ vinsol team']
  s.email     = 'info@vinsol.com'
  s.homepage  = 'http://vinsol.com'
  s.license   = "MIT"

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  spree_version = '>= 3.2.0', '< 4.0.0'

  s.add_dependency 'spree_core', spree_version
  s.add_dependency 'spree_extension', '~> 0.0.5'

  s.add_development_dependency 'appraisal'
  s.add_development_dependency 'coffee-rails', '~> 4.2.1'
  s.add_development_dependency 'database_cleaner', '~> 1.5.3'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'rails-controller-testing', '~> 1.0.1'
  s.add_development_dependency 'rspec-rails', '~> 3.5.2'
  s.add_development_dependency 'rspec-activemodel-mocks', '~> 1.0.3'
  s.add_development_dependency 'sass-rails', '~> 5.0'
  s.add_development_dependency 'shoulda-matchers', '3.1.1'
  s.add_development_dependency 'simplecov', '~> 0.12.0'
  s.add_development_dependency 'sqlite3'
end
