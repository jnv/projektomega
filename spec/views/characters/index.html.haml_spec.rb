require 'spec_helper'

describe "characters/index.html.erb" do
  before(:each) do
    assign(:characters, [
      stub_model(Character,
        :name => "Name",
        :born => "Born",
        :country => "Country",
        :assignment => "Assignment",
        :specialisation => "Specialisation"
      ),
      stub_model(Character,
        :name => "Name",
        :born => "Born",
        :country => "Country",
        :assignment => "Assignment",
        :specialisation => "Specialisation"
      )
    ])
  end

  #it "renders a list of characters" do
  #  render
  #  # Run the generator again with the --webrat flag if you want to use webrat matchers
  #  assert_select "tr>td", :text => "Name".to_s, :count => 2
  #  # Run the generator again with the --webrat flag if you want to use webrat matchers
  #  assert_select "tr>td", :text => "Born".to_s, :count => 2
  #  # Run the generator again with the --webrat flag if you want to use webrat matchers
  #  assert_select "tr>td", :text => "Country".to_s, :count => 2
  #  # Run the generator again with the --webrat flag if you want to use webrat matchers
  #  assert_select "tr>td", :text => "Assignment".to_s, :count => 2
  #  # Run the generator again with the --webrat flag if you want to use webrat matchers
  #  assert_select "tr>td", :text => "Specialisation".to_s, :count => 2
  #end
end
