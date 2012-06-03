require 'spec_helper'

describe Mission do
  def valid_attributes
    FactoryGirl.attributes_for(:mission)
  end

  it "should create a new instance with valid attributes" do
    Mission.create!(valid_attributes)
  end

  describe "associations" do
    it { should have_many(:attendances) }
    it { should have_many(:characters).through(:attendances) }
    it { should have_many(:evaluations) }
  end

  describe "default scope" do
    it_should_behave_like "number sorted model" do
      let(:factory) { :mission }
    end
  end

  describe "validations" do

    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:name) }

    it { should validate_numericality_of(:number) }

    it "should require positive number" do
      Mission.new(name: "Name", number: '-5').should_not be_valid
      Mission.new(name: "Name", number: '0').should_not be_valid
      Mission.new(name: "Name", number: '5').should be_valid
    end

    it "should require unique number" do
      FactoryGirl.create(:mission)
      should validate_uniqueness_of(:number)
    end

  end

  describe "string representations" do
    let(:mission) { Mission.new({name: "Overlord", number: 7}) }

    subject { mission }

    its(:code) { should == "M7" }
    its(:abbr) { should == "M7" }
    its(:full_name) { should == "M7 Overlord" }
    specify { subject.to_s.should == "Overlord" }
  end

end
