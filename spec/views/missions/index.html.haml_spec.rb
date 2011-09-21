require 'spec_helper'

describe "missions/index.html.haml" do
  before(:each) do
    assign(:missions, [
      stub_model(Mission,
        :number => 1,
        :name => "Name",
        :date => "Date",
        :location => "Location",
        :description => "MyText"
      ),
      stub_model(Mission,
        :number => 1,
        :name => "Name",
        :date => "Date",
        :location => "Location",
        :description => "MyText"
      )
    ])
  end

  #it "renders a list of missions" do
  #  render
  #  # Run the generator again with the --webrat flag if you want to use webrat matchers
  #  assert_select "tr>td", :text => 1.to_s, :count => 2
  #  # Run the generator again with the --webrat flag if you want to use webrat matchers
  #  assert_select "tr>td", :text => "Name".to_s, :count => 2
  #  # Run the generator again with the --webrat flag if you want to use webrat matchers
  #  assert_select "tr>td", :text => "Date".to_s, :count => 2
  #  # Run the generator again with the --webrat flag if you want to use webrat matchers
  #  assert_select "tr>td", :text => "Location".to_s, :count => 2
  #  # Run the generator again with the --webrat flag if you want to use webrat matchers
  #  assert_select "tr>td", :text => "MyText".to_s, :count => 2
  #end
end
