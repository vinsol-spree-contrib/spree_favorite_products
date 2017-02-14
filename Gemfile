source 'https://rubygems.org'

# Provides basic authentication functionality for testing parts of your engine
gem 'spree', github: 'spree/spree', branch: '3-2-stable'
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: 'master'

gem 'byebug', '~> 9.0.6'

group :test do
  gem 'rspec-rails', '~> 3.5.2'
  gem 'shoulda-matchers', '3.1.1'
  gem 'simplecov', '~> 0.12.0', require: false
  gem 'database_cleaner', '~> 1.5.3'
  gem 'rspec-activemodel-mocks', '~> 1.0.3'
  gem 'rails-controller-testing', '~> 1.0.1'
end

gemspec
