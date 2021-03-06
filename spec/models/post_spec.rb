require 'spec_helper'

describe Post do

  def valid_attributes
    {character: FactoryGirl.create(:orphaned_character), content: 'Lorem ipsum'}
  end

  it "should create a new instance with valid attributes" do
    Post.create!(valid_attributes)
  end

  describe "associations" do
    it { should belong_to(:character) }
  end

  describe "validations" do
    it { should validate_presence_of(:content) }
    it { should have_readonly_attribute(:character) }
  end

end
