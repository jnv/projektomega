require 'spec_helper'

describe "missions/show.html.haml" do
  before(:each) do
    @mission = assign(:mission, stub_model(Mission,
      :number => 1,
      :name => "Name",
      :date => "Date",
      :location => "Location",
      :description => "MyText"
    ))
  end

  #it "renders attributes in <p>" do
  #  render
  #  # Run the generator again with the --webrat flag if you want to use webrat matchers
  #  rendered.should match(/1/)
  #  # Run the generator again with the --webrat flag if you want to use webrat matchers
  #  rendered.should match(/Name/)
  #  # Run the generator again with the --webrat flag if you want to use webrat matchers
  #  rendered.should match(/Date/)
  #  # Run the generator again with the --webrat flag if you want to use webrat matchers
  #  rendered.should match(/Location/)
  #  # Run the generator again with the --webrat flag if you want to use webrat matchers
  #  rendered.should match(/MyText/)
  #end
end
