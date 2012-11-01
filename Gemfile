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

gem 'thin'
gem 'foreman'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

gem "composite_primary_keys", "~>5.0.6", :git => "git://github.com/drnic/composite_primary_keys.git"
gem "devise", '~> 2.1.0'
gem "cancan", :git => "git://github.com/ryanb/cancan.git", :branch => "2.0"
gem 'formtastic', '~>2.2.0'

gem 'carrierwave'
gem 'mini_magick'

gem 'jquery-rails'

#gem 'haml', :git => "git://github.com/jnv/haml.git", :branch => "issue_438"
gem 'haml', '~> 3.2.0.alpha'
gem 'haml-rails', '>= 0.3.4'
gem "html5-rails"

gem "redcarpet", "~>2.1.1"

gem 'inherited_resources'

group :airbrake do
  gem "airbrake"
end

group :test, :development do
  gem "steak"
  #gem "rspec-rails", "~> 2.6"
  gem "spork-rails"
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
  gem "guard-spork"
  gem "guard-livereload"
  gem "guard-rails"
  gem "guard-rspec"
  gem "rb-inotify"
  gem "libnotify"
  gem "pry"
  gem "pry-stack_explorer"
end