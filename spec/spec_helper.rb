# encoding: utf-8
require 'spork'

ENV["RAILS_ENV"] ||= 'test'
Spork.prefork do
  #Devise
  require "rails/application"
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  require File.dirname(__FILE__) + "/../config/environment.rb"
  #require File.expand_path("../../config/environment", __FILE__)

  require 'rspec/rails'
  require 'shoulda/matchers/integrations/rspec'
  require 'capybara/rspec'
  require 'pry'

  RSpec.configure do |config|
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rspec

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    #CarrierWave
    config.after(:all) do
      if Rails.env.test?
        FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads"])
      end
    end
  end

  #ActiveSupport::Dependencies.clear
end

Spork.each_run do
  # This code will be run each time you run your specs.

  #Factory Girl
  FactoryGirl.reload

  #I18n
  I18n.backend.reload!

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  #ActiveSupport::Dependencies.clear

  Dir["#{Rails.root}/app/controllers//*.rb"].each do |controller|
    load controller
  end
  Dir["#{Rails.root}/app/models//*.rb"].each do |model|
    load model
  end


  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?
    klass.class_eval do
      def cache_dir
        "#{Rails.root}/spec/support/uploads/tmp"
      end

      def store_dir
        "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end
  end
end
