require 'spec_helper'

describe "mission_attendances/show.html.haml" do
  before(:each) do
    @mission_attendance = assign(:mission_attendance, Factory.build(:report))
  end

  before :each do
    stub_ability
  end

  it "renders the whole report" do
    render
    rendered.should have_content(@mission_attendance.character.full_name)
    rendered.should have_content(@mission_attendance.mission.full_name)
    rendered.should have_content(@mission_attendance.report)
  end
end
