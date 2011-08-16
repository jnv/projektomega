source 'http://rubygems.org'

gem 'rails', '3.1.0.rc5'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.1.0.rc"
  gem 'coffee-rails', "~> 3.1.0.rc"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test, :development do
  gem "rspec-rails", "~> 2.6"
  gem "guard-spork"
  gem "spork", "~> 0.9.0.rc"
end

group :test do
  gem "capybara", "~> 1.0"
  gem "factory_girl_rails"
  gem "forgery", "~>0.3.12"
end

group :development do
  gem "guard-livereload"
  gem "guard-rails"
  #gem "guard-rspec"
  gem "rb-inotify"
  gem "libnotify"
  gem "active_reload"
end
