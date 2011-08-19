module ControllerMacros
  def login_admin
    @request.env["devise.mapping"] = Devise.mappings[:user]
    admin = Factory.create(:admin)
    sign_in admin
    admin
  end


  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = Factory.create(:user)
    #user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
    sign_in user
    user
  end
end

RSpec.configure do |config|
  config.include ControllerMacros, type: :controller
end