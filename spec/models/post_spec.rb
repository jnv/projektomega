require 'spec_helper'

describe Post do

  def valid_attributes
    {character: Factory(:orphaned_character), content: 'Lorem ipsum'}
  end

  it "should create a new instance with valid attributes" do
    Post.create!(valid_attributes)
  end

  describe "associations" do
    it { should belong_to(:character) }
  end

  describe "validations" do
    it { should validate_presence_of(:content) }
  end

end
