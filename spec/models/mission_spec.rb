require 'spec_helper'

describe Mission do
  def valid_attributes
    {number: '1', name: 'Mata Hari'}
  end

  it "should create a new instance with valid attributes" do
    Character.create!(valid_attributes)
  end

  describe "associations" do
    #it { should belong_to :user }
  end

  describe "validations" do

    it { should validate_presence_of(:number)}
    it { should validate_presence_of(:name)}

    it { should validate_numericality_of(:number)}

    it "should require positive number" do
      Mission.new(name: "Name", number: '-5').should_not be_valid
      Mission.new(name: "Name", number: '0').should_not be_valid
      Mission.new(name: "Name", number: '5').should be_valid
    end

    it "should require unique number" do
      Factory.create(:mission)
      should validate_uniqueness_of(:number)
    end

  end

  describe "string representations" do
    let(:mission) { Mission.new({name: "Overlord", number: 7}) }

    subject { mission }

    its(:code) { should == "M7" }
    its(:abbr) { should == "M7" }
    its(:full_name) { should == "M7 Overlord"}
    specify {subject.to_s.should == "Overlord"}
  end

end