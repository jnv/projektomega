source 'http://rubygems.org'

gem 'rails', '3.1.0.rc6'

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
gem 'haml'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem "devise"
gem "cancan", :git => "git://github.com/ryanb/cancan.git", :branch => "2.0"

gem 'formtastic', '~>2.0.0.rc1'

gem 'carrierwave'
gem 'mini_magick'

group :test, :development do
  gem "rspec-rails", "~> 2.6"
  gem 'haml-rails', '>= 0.3.4'
  gem "guard-spork"
  gem "spork", ">= 0.9.0.rc"
  gem "guard-livereload"
  gem "guard-rails"
  gem "guard-rspec"
  gem "rb-inotify"
  gem "libnotify"
end

group :test do
  gem "capybara", "~> 1.0"
  gem "factory_girl_rails", "~> 1.1"
  gem "forgery", "~>0.3.12"
  gem "shoulda-matchers"
  #gem 'simplecov', '>= 0.4.0', :require => false
end

group :development do
  gem "active_reload"
end
