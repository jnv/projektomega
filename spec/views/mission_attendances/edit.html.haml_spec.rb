# encoding: utf-8
require 'spec_helper'

describe "mission_attendances/edit.html.haml" do
  before(:each) do
    @mission_attendance = assign(:mission_attendance, FactoryGirl.create(:report))
  end

  before :each do
    stub_ability
  end

  it "renders the edit mission_attendance form" do
    render

    rendered.should have_content(@mission_attendance.character.full_name)
    rendered.should have_content(@mission_attendance.mission.full_name)
    rendered.find("form[method='post'][action='#{mission_attendance_path(@mission_attendance)}']").tap do |form|
      form.should have_field("Obsah hlášení")
    end
  end

end
