# frozen_string_literal: true

source 'https://rubygems.org'

ruby '~> 2.6.0'

gem 'jbuilder', '~> 2.7'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.0'
gem 'sqlite3', '~> 1.4'

gem 'rack-cors'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.1.0'
  gem 'rspec-rails', '~> 4.0.0'
  gem 'rubocop', '~> 1.7.0', require: false
  gem 'rubocop-rails', '~> 2.9.0', require: false
  gem 'rubocop-rspec', '~> 2.1.0', require: false
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end
