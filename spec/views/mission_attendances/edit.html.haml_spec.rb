require 'spec_helper'

describe "mission_attendances/edit.html.haml" do
  before(:each) do
    @mission_attendance = assign(:mission_attendance, stub_model(MissionAttendance))
  end

  it "renders the edit mission_attendance form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => mission_attendances_path(@mission_attendance), :method => "post" do
    end
  end
end
