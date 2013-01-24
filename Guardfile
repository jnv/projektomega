group :test do
  guard 'spork', :rspec_env => {'RAILS_ENV' => 'test'} do
    watch('config/application.rb')
    watch('config/environment.rb')
    watch(%r{^config/environments/.*\.rb$})
    watch(%r{^config/initializers/.*\.rb$})
    watch('Gemfile')
    watch('Gemfile.lock')
    watch('spec/spec_helper.rb') { :rspec }
    watch('test/test_helper.rb') { :test_unit }
    watch(%r{features/support/}) { :cucumber }
  end

  guard 'rspec', :all_on_start => false, :cli => "--color --format nested --fail-fast --drb" do
    watch('spec/spec_helper.rb') { "spec" }
    watch('config/routes.rb') { "spec/routing" }
    watch('app/controllers/application_controller.rb') { "spec/controllers" }
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^app/(.*)(\.erb|\.haml)$}) { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
    watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch(%r{^app/controllers/(.+)_(controller)\.rb$}) { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
    watch(%r{^spec/support/acceptance/(.+)\.rb$}) { "spec/acceptance" }
  end
end

#guard 'rspec', :version => 2,  do
#  watch(%r{^spec/.+_spec\.rb$})
#  watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
#  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
#
#
#  watch(%r{^spec/support/acceptance/(.+)\.rb$}) { "spec/acceptance" }
#
#  # Steak acceptance specs
#  #watch(%r{^app/views/(.+)/.*\.(erb|haml)$}) do |m|
#  #  fname = "spec/acceptance/#{m[1]}_spec.rb"
#  #  if File.exists?(fname)
#  #    fname
#  #  else
#  #    "spec/acceptance/"
#  #  end
#  #end
#end


group :rails do
  guard 'livereload' do
    watch(%r{app/views/.+\.(erb|haml|slim)$})
    watch(%r{app/helpers/.+\.rb})
    watch(%r{public/.+\.(css|js|html)})
    watch(%r{config/locales/.+\.yml})
    # Rails Assets Pipeline
    watch(%r{(app|vendor)/assets/\w+/(.+\.(css|js|html)).*})  { |m| "/assets/#{m[2]}" }
  end

  guard 'rails' do
    watch('Gemfile.lock')
    #watch(%r{^(config|lib)/.*})
  end
end
