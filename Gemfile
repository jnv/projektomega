source 'http://rubygems.org'

gem 'rails', '~> 3.2.11'
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

  gem 'compass-rails'
  gem 'zurb-foundation'

  gem 'chosen-rails'
end

gem 'thin', require: false
gem 'foreman', require: false
gem 'yaml_db'#, require: false

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# Rack
gem 'rack-canonical-host'

#Auth
gem "devise", '~> 2.1.0'
gem "cancan", :git => "git://github.com/ryanb/cancan.git", :branch => "2.0"

# Controllers & Views
gem 'inherited_resources'
gem 'formtastic', '~>2.2.0'
gem 'simple_form'
gem 'haml', '~> 3.2.0.alpha'
gem 'haml-rails', '>= 0.3.4'
gem "html5-rails"

gem "redcarpet", "~>2.2.2"

# Models
gem "composite_primary_keys", "~>5.0.10"
gem 'carrierwave'
gem 'mini_magick'

# JS
gem 'jquery-rails'

gem 'comfortable_mexican_sofa'

gem "airbrake"

group :test, :development do
  # gem "steak"
  gem "rspec-rails"
  gem "spork-rails"
  gem "capybara", "~>2.0"
end

group :test do
  gem "factory_girl_rails"#, :require => false
  gem "forgery"
  gem "shoulda-matchers"
  gem "database_cleaner"
  #gem 'simplecov', '>= 0.4.0', :require => false
end

group :development do
  gem "launchy"
  #gem "active_reload"
  gem "vendorer"
  # To use debugger
  # gem 'ruby-debug19', :require => 'ruby-debug'
  #gem "yaml_db"
  gem 'capistrano'
  gem 'sextant'

  gem 'rb-inotify', '~> 0.8.8', require: false
  gem 'guard'

  gem "guard-spork"
  gem "guard-livereload"
  gem "guard-rails"
  gem "guard-rspec"
end
