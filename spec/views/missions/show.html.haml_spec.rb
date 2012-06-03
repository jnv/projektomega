# encoding: utf-8
require 'spec_helper'

describe "missions/show.html.haml" do
  before(:each) do
    @mission = assign(:mission, FactoryGirl.build(:attended_mission))
    stub_ability
  end

  it "renders attending agents" do
    render
    rendered.should have_selector("h3", content: "Zúčastnění agenti")
    @mission.characters.each do |ch|
      rendered.should have_link(ch.full_name)
    end
  end

end
