source 'http://rubygems.org'

gem 'rails', '~> 3.2.5'
gem 'rake'

group :sqlite do
  gem 'sqlite3'
end
group :mysql do
  gem 'mysql2'
end
group :postgres do
  gem 'pg'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.2.0"
  gem 'coffee-rails', "~> 3.2.0"
  gem 'uglifier'
  #gem 'compass', '~> 0.12.alpha'
  gem 'compass-rails'
  gem 'compass-h5bp'
  #gem "compass-html5", :git => "git://github.com/sporkd/compass-html5.git"
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

gem "composite_primary_keys", "~>5.0.6"
gem "devise", '~> 1'
gem "cancan", :git => "git://github.com/ryanb/cancan.git", :branch => "2.0"
gem 'formtastic', '~>2.0.0.rc'

gem 'carrierwave'
gem 'mini_magick'

gem 'jquery-rails'

#gem 'haml', :git => "git://github.com/jnv/haml.git", :branch => "issue_438"
gem 'haml', '~> 3.2.0.alpha'
gem 'haml-rails', '>= 0.3.4'
gem "html5-rails"

gem "redcarpet", "~>2.0.0b5"

group :airbrake do
  gem "airbrake"
end

group :test, :development do
  gem "steak"
  #gem "rspec-rails", "~> 2.6"
  gem "spork", ">= 0.9.0.rc"
  gem "database_cleaner"
end

group :test do
  gem 'factory_girl_rails', '~> 1.6'
  gem "forgery", "~>0.3.12"
  gem "shoulda-matchers"
  #gem 'simplecov', '>= 0.4.0', :require => false
end

group :development do
  gem "launchy"
  #gem "active_reload"
  gem "vendorer"
  # To use debugger
  # gem 'ruby-debug19', :require => 'ruby-debug'
  #gem "yaml_db"
end

group :pry do
  gem "pry"
  gem "pry-stack_explorer"
  #gem 'pry-rails'
end

group :guard do
  gem "guard-spork"
  gem "guard-livereload"
  gem "guard-rails"
  gem "guard-rspec"
  gem "rb-inotify"
  gem "libnotify"
end
