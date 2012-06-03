require 'spec_helper'

describe UsersController do

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all characters as @characters" do
      User.stub(:all) { [mock_user] }
      get :index
      assigns(:users).should eq([mock_user])
    end
  end


  describe "GET 'show' for logged in user" do
    before do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    
    it "should be successful" do
      get :show, :id => @user.id
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user.id
      assigns(:user).should == @user
    end

  end

  describe "GET new" do
    it "should not respond" do
      lambda { get(:new) }.should raise_error
    end
  end

end