require 'spec_helper'

describe User do

  it "should create a new instance given a valid attribute" do
    user = Factory.build(:user)
    user.save!
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :role }

    it { should_not allow_value("blah").for(:email) }
    it { should allow_value("a@b.com").for(:email) }
    it "should reject invalid email addresses" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. asda]
      addresses.each do |address|
        should_not allow_value(address).for(:email)
      end
    end
  end

  describe "uniqueness validations" do
    before do
      Factory.create(:user)
    end

    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:name).case_insensitive }

  end

  describe "roles" do

    it { should_not allow_value("asdasd").for(:role) }
    it "should accept only defined roles" do
      User::ROLES.each do |role|
        should allow_value(role).for(:role)
      end
    end
    it { should allow_value("admin").for(:role) }
    it { should allow_value("user").for(:role) }
    it { should allow_value("coordinator").for(:role) }

    it "should set user as a default role" do
      user = User.new
      user.role.should == 'user'
    end

  end

  describe "password validations" do
    it "should reject short passwords" do
      short = "a" * 5
      should_not allow_value(short).for(:password)
    end

    it "should require password confirmation" do
      user = Factory.build(:user)
      user.password = "abc123"
      user.password_confirmation = "123abc"
      user.should_not be_valid
    end

  end

  describe "password encryption" do

    before do
      @user = Factory.create(:user)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

  end


end
