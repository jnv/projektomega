require 'spec_helper'

describe MissionAttendance do
  it "should have multiple primary ids" do
    MissionAttendance.primary_key.should eq(['mission_id', 'character_id'])
  end

  describe "associations" do
    it { should belong_to :mission }
    it { should belong_to :character }
    it "has many evaluations" do
      MissionAttendance.reflect_on_association(:evaluations).macro.should == :has_many #XXX Shoulda doesn't like CPK
    end
  end


  describe "scopes" do
    before do
      @mission = FactoryGirl.create(:attended_mission, attendees: 4)
      @evaluation = FactoryGirl.create(:evaluation, attended_mission: @mission)
      @evaluation2 = FactoryGirl.create(:evaluation, {attended_mission: @mission, author: @mission.characters[3]})
    end

    specify { MissionAttendance.joins(:evaluations).count.should == 2 }

    describe "#with_evaluations" do
      subject { MissionAttendance.with_evaluations }
      its(:count) { should == @mission.attendances.count}
    end
  end

  describe "#character_user" do
    subject { MissionAttendance.new }
    it { should respond_to(:character_user) }
  end

  #it "should return non-empty reports" do
  #  report = FactoryGirl.create(:report)
  #  Factory(:mission_attendance)
  #
  #  MissionAttendance.reports
  #end

end
