unless ENV['AIRBRAKE_API_KEY'].blank?
  Airbrake.configure do |config|
    config.api_key = ENV['AIRBRAKE_API_KEY']
    config.host    = ENV['AIRBRAKE_HOST'] unless ENV['AIRBRAKE_HOST'].blank?
    config.port    = 80
    config.secure  = config.port == 443
  end
end
