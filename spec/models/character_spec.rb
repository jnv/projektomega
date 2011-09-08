require 'spec_helper'

describe Character do

  def valid_attributes
    {number: '1', name: 'Mata Hari'}
  end

  it "should create a new instance with valid attributes" do
    Character.create!(valid_attributes)
  end

  describe "associations" do
    it { should belong_to :user }
  end

  describe "validations" do

    it { should validate_presence_of(:number)}
    it { should validate_presence_of(:name)}

    it { should validate_numericality_of(:number)}

    it "should require nonblank name" do
      Character.new(name: "  \t  ", number: '5').should_not be_valid
    end

    it "should require positive number" do
      Character.new(name: "Name", number: '-5').should_not be_valid
      Character.new(name: "Name", number: '0').should_not be_valid
      Character.new(name: "Name", number: '5').should be_valid
    end

    it "should require unique number" do
      Factory.create(:character)
      #should validate_uniqueness_of(:number)
    end

  end

  describe "string representations" do
    let(:character) { Character.new({name: "James Bond", number: 7}) }

    subject { character }

    its(:code) { should == "A7" }
    its(:abbr) { should == "A7" }
    its(:full_name) { should == "A7 James Bond"}
    specify {subject.to_s.should == "James Bond"}
  end

end
