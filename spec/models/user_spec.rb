require 'spec_helper'

describe User do

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }

    it { should_not allow_value("blah").for(:email) }
    it { should allow_value("a@b.com").for(:email) }
  end

  describe "uniqueness validations" do
    before do
      Factory.create(:user)
    end

    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:name) }

  end

  it "should set user as a default role" do
    user = User.new
    user.role.should == 'user'
  end


end
