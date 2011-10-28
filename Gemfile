source 'http://rubygems.org'

gem 'rails', '~> 3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'haml', :git => "git://github.com/jnv/haml.git", :branch => "issue_438"

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem "devise"
gem "cancan", :git => "git://github.com/ryanb/cancan.git", :branch => "2.0"

gem 'formtastic', '~>2.0.0.rc'

gem 'carrierwave'
gem 'mini_magick'

gem "compass", "~>0.12.alpha"
gem "html5-rails", :git => "git://github.com/sporkd/html5-rails.git"
gem "compass-html5", :git => "git://github.com/sporkd/compass-html5.git"

gem "composite_primary_keys", "~>4.0.0"

gem "airbrake"

gem "redcarpet", "~>2.0.0b5"

group :test, :development do
  gem 'steak'
  #gem "rspec-rails", "~> 2.6"
  gem 'haml-rails', '>= 0.3.4'
  gem "guard-spork"
  gem "spork", ">= 0.9.0.rc"
  gem "guard-livereload"
  gem "guard-rails"
  gem "guard-rspec"
  gem "rb-inotify"
  gem "libnotify"
  gem "database_cleaner"
end

group :test do
  gem "launchy"
  gem 'factory_girl_rails', '~> 1.2', :require => false
  gem 'factory_girl', '~> 2.1', :require => false
  gem "forgery", "~>0.3.12"
  gem "shoulda-matchers"
  #gem 'simplecov', '>= 0.4.0', :require => false
end

group :development do
  gem "active_reload"
  gem "livereload"
  #gem 'pry-rails'
end
