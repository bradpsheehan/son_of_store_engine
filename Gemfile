source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'jquery-rails'
gem 'rake'
gem 'unicorn'
gem 'bootstrap-sass'
gem 'simple_form'
gem 'jquery-rails'
gem 'sorcery'
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'
gem 'pg'
gem 'validation-scopes'
gem 'resque'
gem 'redis-store', '~> 1.0.0'

group :production do
  gem 'pg'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'cane'
  gem 'reek'
  gem 'debugger'
  gem 'capybara'
  gem 'simplecov'
  gem 'newrelic_rpm'
end

group :test do
  gem 'faker'
  gem 'guard-rspec'
  gem 'launchy'
end
