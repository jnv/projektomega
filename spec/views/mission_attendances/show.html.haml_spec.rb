require 'spec_helper'

describe "mission_attendances/show.html.haml" do
  before(:each) do
    @mission_attendance = assign(:mission_attendance, stub_model(MissionAttendance))
  end

  it "renders attributes in <p>" do
    render
  end
end
