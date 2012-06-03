module ControllerMacros
  def login_admin
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @admin ||= FactoryGirl.create(:admin)
    sign_in @admin
    @admin
  end


  def login_user(user = nil)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = user || FactoryGirl.create(:user)
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
  def controller_actions_should_fail(cont, opts={})
    except= opts[:except] || []
    actions_to_test= get_all_actions(cont).reject { |a| except.include?(a) } #controller_class.action_methods
    actions_to_test += opts[:include] if opts[:include]
    actions_to_test.each do |a|
      get a
      response.should_not be_success
      #response.should redirect_to('http://test.host/login')
      #flash[:warning].should == @login_warning
    end
  end


  # http://stackoverflow.com/questions/6152359/dynamically-generating-shared-examples-in-rspec-2
  shared_examples "authorized controller" do |actions|
    actions.each_pair do |action, verb|
      specify "denying access to ##{action}" do
        send(verb, action, {id: 1})
        #response.status.should be 302
        response.status.should be 302
        flash[:alert].should_not be_empty
      end
    end
  end

  # http://stackoverflow.com/questions/4491101/rspec-and-cancan-controller-testing
  def mock_ability
    ability = Object.new
    #ability = double("ability")
    ability.extend(CanCan::Ability)
    controller.stub!(:current_ability).and_return(ability)
    #ability.should_receive(:can?).at_least(:once) #FIXME authorize! is called twice
    ability.stub!(:can?)
  end

  def stub_can
    Ability.any_instance.stub(:can?)
  end


end

RSpec.configure do |config|
  config.include ControllerMacros, :type => :controller
end
