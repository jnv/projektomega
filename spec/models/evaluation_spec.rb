require 'spec_helper'

describe Evaluation do

  describe "associations" do
    it { should belong_to :character }
    it { should belong_to :mission }
    it { should belong_to :author }
  end

  describe "validations" do

    it { should validate_presence_of(:mission)}
    it { should validate_presence_of(:character)}
    it { should validate_presence_of(:author)}
    it { should validate_presence_of(:content)}

    it "shouldn't allow author to be same as character" do
      attendance = Factory(:attendance)
      mission = attendance.mission
      character = attendance.character

      lambda do
        Evaluation.create!({author: character, character: character, mission: mission, content: 'blah'})
      end.should raise_error
    end

    it "shouldn't accept author or character who haven't attended the mission" do
      mission = Factory(:mission)
      character = Factory(:character)
      author = Factory(:character)

      lambda do
        Evaluation.create!({author: character, character: author, mission: mission, content: 'blah'})
      end.should raise_error
    end

  end

end
