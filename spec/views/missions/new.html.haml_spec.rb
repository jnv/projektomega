require 'spec_helper'

describe "missions/new.html.haml" do
  before(:each) do
    assign(:mission, stub_model(Mission,
      :number => 1,
      :name => "MyString",
      :date => "MyString",
      :location => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new mission form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => missions_path, :method => "post" do
      assert_select "input#mission_number", :name => "mission[number]"
      assert_select "input#mission_name", :name => "mission[name]"
      assert_select "input#mission_date", :name => "mission[date]"
      assert_select "input#mission_location", :name => "mission[location]"
      assert_select "textarea#mission_description", :name => "mission[description]"
    end
  end
end
