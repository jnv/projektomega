namespace :ci do

  desc "Copy database configuration based on DB environment variable"
  task :config do
    FileUtils.cp "config/database.#{ENV['DB'] || 'sqlite'}.yml", "config/database.yml"
  end

  desc "Setup CI database configuration and setup"
  task :setup => [:config, :'db:test:prepare']
end