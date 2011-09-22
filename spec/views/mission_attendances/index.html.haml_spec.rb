require 'spec_helper'

describe "mission_attendances/index.html.haml" do
  before(:each) do
    assign(:mission_attendances, [
      stub_model(MissionAttendance),
      stub_model(MissionAttendance)
    ])
  end

  it "renders a list of mission_attendances" do
    render
  end
end
