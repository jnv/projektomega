module ControllerMacros
  def login_admin
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @admin ||= Factory.create(:admin)
    sign_in @admin
    @admin
  end


  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user ||= Factory.create(:user)
    #user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
    sign_in @user
    @user
  end

  def get_all_actions(cont)
    c = Module.const_get(cont.to_s.pluralize.capitalize + "Controller")
    c.public_instance_methods(false).reject { |action| ['rescue_action'].include?(action) }
  end

  # test actions fail if not logged in
  # opts[:exclude] contains an array of actions to skip
  # opts[:include] contains an array of actions to add to the test in addition
  # to any found by get_all_actions
  # source: http://blog.wolfman.com/articles/2007/7/28/rspec-testing-all-actions-of-a-controller
  def controller_actions_should_fail_if_not_logged_in(cont, opts={})
    except= opts[:except] || []
    actions_to_test= get_all_actions(cont).reject { |a| except.include?(a) } #controller_class.action_methods 
    actions_to_test += opts[:include] if opts[:include]
    actions_to_test.each do |a|
      #puts "... #{a}"
      get a
      response.should_not be_success
      #response.should redirect_to('http://test.host/login')
      #flash[:warning].should == @login_warning
    end
  end

end

RSpec.configure do |config|
  config.include ControllerMacros, type: :controller
end
