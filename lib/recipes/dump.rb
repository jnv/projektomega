namespace :dump do
  desc "Dump data using yaml_db and copy file into db/data.yml"
  task :db do
    rake = fetch(:rake, 'rake')
    rails_env = fetch(:rails_env, 'production')

    remotefile = "#{current_path}/db/data.yml"
    localfile = "db/data.yml"
    run "cd '#{current_path}' && #{rake} db:data:dump RAILS_ENV=#{rails_env}"
    download remotefile, localfile, via: :scp
    run "rm #{remotefile}"
  end

  task :uploads do
    remotepath = "#{shared_path}/uploads"
    localpath = "public/uploads"
    download remotepath, localpath, via: :scp, recursive: true
  end
end
