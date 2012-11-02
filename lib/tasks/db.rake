Rake::Task['db:test:prepare'].enhance do
  Rake::Task['db:test:cms_fixtures'].invoke
end

Rake::Task['db:setup'].enhance do
  Rake::Task["db:cms_fixtures"].invoke
end

namespace :db do
  namespace :test do
    task :cms_fixtures do
      ENV['RAILS_ENV'] = 'test'
      ENV['FROM'] = 'projektomega'
      ENV['TO']   = 'test.host'
      Rake::Task['comfortable_mexican_sofa:fixtures:import'].invoke
    end
  end

  task :cms_fixtures do
    ENV['FROM'] = 'projektomega'
    ENV['TO']   = 'projektomega.cz'
    Rake::Task['comfortable_mexican_sofa:fixtures:import'].invoke
  end
end