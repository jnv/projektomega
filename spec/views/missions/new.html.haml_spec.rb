# encoding: utf-8
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

    stub_ability
  end

  it "renders new mission form" do
    render

    rendered.find("form[method='post'][action='#{missions_path}']").tap do |form|
      form.should have_required_field("Číslo mise")
      form.should have_not_readonly_field("Číslo mise")
      form.should have_required_field("Název")
      form.should have_not_required_field("Lokace")
      form.should have_not_required_field("Datum")
      form.should have_not_required_field("Popis")
    end

  end

end
