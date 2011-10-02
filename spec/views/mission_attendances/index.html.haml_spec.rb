require 'spec_helper'

describe "mission_attendances/index.html.haml" do
  before(:each) do
    assign(:mission_attendances, [
      Factory.build(:report),
      Factory.build(:report)
    ])
  end

  before do
    stub_ability
  end

  it "renders a list of mission_attendances" do
    render
    pending "Decide how to show list of resports"
  end
end
