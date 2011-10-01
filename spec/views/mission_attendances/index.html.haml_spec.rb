require 'spec_helper'

describe "mission_attendances/index.html.haml" do
  before(:each) do
    assign(:mission_attendances, [
      Factory.build(:report),
      Factory.build(:report)
    ])
  end

  it "renders a list of mission_attendances" do
    render
  end
end
