require 'spec_helper'

describe "mission_attendances/new.html.haml" do
  before(:each) do
    assign(:mission_attendance, stub_model(MissionAttendance).as_new_record)
  end

  it "renders new mission_attendance form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => mission_attendances_path, :method => "post" do
    end
  end
end
