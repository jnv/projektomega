# encoding: utf-8
require 'spec_helper'

describe "missions/edit.html.haml" do
  before(:each) do
    @mission = assign(:mission, stub_model(Mission,
      :number => 1,
      :name => "MyString",
      :date => "MyString",
      :location => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit mission form" do
    render

    rendered.find("form[method='post'][action='#{mission_path(@mission)}']").tap do |form|
      form.should have_readonly_field("Číslo mise")
    end

  end
end
