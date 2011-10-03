# encoding: utf-8
require 'spec_helper'

describe "mission_attendances/index.html.haml" do
  before(:each) do
    @full = Factory.build(:report)
    @empty = Factory.build(:attendance, report: nil)
    assign(:mission_attendances, [
      @full,
      @empty
    ])
  end

  before do
    stub_ability
  end

  it "renders a list of mission_attendances" do
    render
    rendered.find("#mission_attendances").tap do |attendances|
      attendances.find('.mission_attendance', count: 2)
    end
  end

  it "renders link for a filled report" do
    render
    rendered.find(css_dom_id(@full)).tap do |full|
      full.should have_link("Zobrazit")
    end
  end

  it "doesn't render link for an empty report" do
    render
    rendered.find(css_dom_id(@empty)).tap do |empty|
      empty.should have_content("Nedodáno")
    end
  end
end
