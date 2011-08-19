# XXX Unused
module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      admin = Factory.create(:admin)
      sign_in admin
      admin
    end
  end


  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = Factory.create(:user)
      #user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in user
      user
    end
  end
end
