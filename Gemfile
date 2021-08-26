source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'rails', '~> 5.2.5'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

gem 'cancancan'
gem 'devise'
gem 'devise-i18n'
gem 'rails_admin', '~> 2.0'

gem 'carrierwave'
gem 'mini_magick'

gem 'ransack'

gem 'kaminari'

gem 'coderay'
gem 'redcarpet'

gem 'faker'

gem 'dotenv-rails'
gem 'unicorn'
gem 'mini_racer', platforms: :ruby

gem 'fog-aws'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'

  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.8'

  gem 'capistrano', '3.6.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-unicorn'

  gem 'ed25519'
  gem 'bcrypt_pbkdf'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'

  gem 'letter_opener_web'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'database_cleaner'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
