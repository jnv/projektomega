namespace :cms do
  desc "Import CMS fixtures"
  task :import do
    rake = fetch(:rake, 'rake')
    rails_env = fetch(:rails_env, 'production')
    from = fetch(:cms_from, 'projektomega')
    fixt_to = fetch(:cms_to, 'projektomega')

    run "cd '#{current_path}' && #{rake} comfortable_mexican_sofa:fixtures:import FROM=#{from} TO=#{fixt_to} RAILS_ENV=#{rails_env}"
  end
end
