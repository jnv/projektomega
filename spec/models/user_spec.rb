require 'spec_helper'

describe User do

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :role }

    it { should_not allow_value("blah").for(:email) }
    it { should allow_value("a@b.com").for(:email) }
  end

  describe "uniqueness validations" do
    before do
      Factory.create(:user)
    end

    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:name).case_insensitive }

  end

  it "should set user as a default role" do
    user = User.new
    user.role.should == 'user'
  end

  describe "roles" do
    it { should_not allow_value("asdasd").for(:role) }
    it { should allow_value("admin").for(:role) }
    it { should allow_value("user").for(:role) }
    it { should allow_value("coordinator").for(:role) }
  end


end
