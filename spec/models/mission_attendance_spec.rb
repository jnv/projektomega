require 'spec_helper'

describe MissionAttendance do
  it "should have multiple primary ids" do
    MissionAttendance.primary_key.should eq([:mission_id, :character_id])
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
      @mission = Factory(:attended_mission, attendees: 4)
      @evaluation = Factory(:evaluation, attended_mission: @mission)
      @evaluation2 = Factory(:evaluation, {attended_mission: @mission, author: @mission.characters[3]})
    end

    specify { MissionAttendance.joins(:evaluations).count.should == 2 }

    describe "#evaluations_all" do
      subject { MissionAttendance.with_evaluations }
      its(:count) { should == @mission.attendances.count}
    end
  end

  describe "#character_user" do
    subject { MissionAttendance.new }
    it { should respond_to(:character_user) }
  end

  #it "should return non-empty reports" do
  #  report = Factory :report
  #  Factory :mission_attendance
  #
  #  MissionAttendance.reports
  #end

end
