RSpec.configure do |config|

  config.use_transactional_fixtures = false

  config.before :each do
    if example.metadata[:js] #Capybara.current_driver != :rack_test
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
    end
    DatabaseCleaner.start
  end

  config.after do

    begin
      DatabaseCleaner.clean
    rescue
    end
    
  end


end