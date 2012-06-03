require 'spec_helper'

describe Evaluation do

  it "should have multiple primary ids" do
    Evaluation.primary_key.should eq([:mission_id, :character_id, :author_id])
  end

  describe "associations" do
    it { should belong_to :character }
    it { should belong_to :mission }
    it { should belong_to :author }
    
    it "belongs to attendance" do
      Evaluation.reflect_on_association(:attendance).macro.should == :belongs_to #XXX Shoulda doesn't like CPK
    end
  end

  describe "group_by_{mission|character}" do
    before do
      @count = 2
      @mission = FactoryGirl.create(:mission)
      @attendances = FactoryGirl.create_list(:attendance, @count, {mission: @mission})

      @eval1 = FactoryGirl.create(:evaluation, {mission: @mission, author: @attendances.first.character, character: @attendances.last.character})
      @eval2 = FactoryGirl.create(:evaluation, {mission: @mission, author: @attendances.last.character, character: @attendances.first.character})
    end

    it "returns evaluations grouped by missions" do
      ev = Evaluation.group_by_mission.first
      ev[0].should == @mission
      ev[1].count.should == @count
    end

    it "returns evaluations grouped by character" do
      evs = Evaluation.group_by_character
      evs.count.should == @count
      evs.first[0].should == @eval2.character
      evs.first[1].should == [@eval2]
    end


  end

  describe "validations" do

    it { should validate_presence_of(:mission) }
    it { should validate_presence_of(:character) }
    it { should validate_presence_of(:author) }
    it { should validate_presence_of(:content) }

    it "shouldn't allow author to be same as character" do
      attendance = FactoryGirl.create(:attendance)
      mission = attendance.mission
      character = attendance.character

      lambda do
        Evaluation.create!({author: character, character: character, mission: mission, content: 'blah'})
      end.should raise_error
    end

    it "shouldn't accept author or character who haven't attended the mission" do
      mission = FactoryGirl.create(:mission)
      character = FactoryGirl.create(:character)
      author = FactoryGirl.create(:character)

      lambda do
        Evaluation.create!({author: character, character: author, mission: mission, content: 'blah'})
      end.should raise_error
    end

  end

end
