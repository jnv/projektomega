require 'spec_helper'

describe MissionAttendance do

  describe "associations" do
    it { should belong_to :mission }
    it { should belong_to :character }
    it "has many evaluations" do
      MissionAttendance.reflect_on_association(:evaluations).macro.should == :has_many #XXX Shoulda doesn't like CPK
    end
  end

  it "should have multiple primary ids" do
    MissionAttendance.primary_key.should eq([:mission_id, :character_id])
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
